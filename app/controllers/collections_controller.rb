class CollectionsController < ProtectedController
  before_action :set_collection, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show] # read only

  # POST /collections
  def create
    if current_user
      new_collection = current_user.collections.new(collection_params)

      if new_collection.save
        # require 'pry'; binding.pry
        render json: new_collection, status: :created
      else
        render json: new_collection.errors, status: :unprocessable_entity
      end
    else
      head :unauthorized
    end
  end

  # PUT/PATCH /collections/:id
  def update
    author = @collection.user_id
    if current_user.id == author

      if @collection.update_attributes(:name => collection_params[:name], :desc => collection_params[:desc])
        #  @collection.update_attribute(:cover, collection_params[:cover])
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
    author = @collection.user_id
    if current_user.id == author
      @collection.destroy
      head :no_content
    else
      head :unauthorized
    end
  end

  # GET /mycollections
  def my_collections
  # finds all collection belonging to current_user
    render json: Collection.where(:user_id => current_user.id)
  end

  # GET /collections
  # Browse everyone's collections
  def index
    render json: Collection.all
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
      params.require(:collection).permit(:name, :desc, :cover)
    end

    private :set_collection, :collection_params
end
