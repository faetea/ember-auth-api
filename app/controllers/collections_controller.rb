class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show] # read only
  # require auth for [:create, :update, :destroy, :my_collections]
  # current_user call to get authenticated user (or nil)

  # PATCH/PUT /collections/:id
  def update
  # if current_user is same as collection_owner
    if current_user == @collection.user_id
      console.log('who is current_user? | collection update')
      console.log(current_user)

      if @collection.update(@collection.id, collection_params)
        render json: @collection, status: :ok
      else
        render json: @collection.errors, status: :unprocessable_entity
      end

    else
      head :unauthorized
    end
  end

  # DELETE /collections/:id
  def destroy
  # if current_user is same as collection_owner
    if current_user == @collection.user_id
      @collection.destroy
      head :no_content
    else
      head :unauthorized
    end
  end

  # POST /collections
  def create
    @new_collection = Collection.new(collection_params)

    if @new_collection.save
      render json: @new_collection, status: :created
    else
      render json: @new_collection.errors, status: :unprocessable_entity
    end
  end

  # GET /mycollections
  # Index all of current_user's collections
  def my_collections
  # finds all collection belonging to current_user
    render json: Collection.where(:user_id => current_user.id)
  end

  # GET /collections
  # Browse everyone's collections
  def index
    @collections = Collection.all

    render json: @collections
  end

  # GET /collections/:id
  # Browse a specific collections
  def show
    render json: @collection
  end


  private

    def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(:name, :desc, :image, :user_id)
    end

    private :set_collection, :collection_params
end
