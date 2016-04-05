class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :update, :destroy]

  # POST /collections
  def create
    @collection = Collection.new(collection_params)

    if @collection.save
      render json: @collection, status: :created
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  # GET /collections
  def index
    @collections = Collection.all

    render json: @collections
  end

  # GET /collections/1
  def show
    render json: @collection
  end

  # PATCH/PUT /collections/1
  def update
    if @collection.update(collection_params)
      # head :no_content
      render json: @collection, status: :updated
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /collections/1
  def destroy
    @collection.destroy

    head :no_content
  end

  private

    def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.permit(:name, :desc, :image, :user_id)
    end

    private :set_collection, :collection_params
end
