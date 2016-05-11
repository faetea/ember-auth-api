class ArtsController < ProtectedController
  before_action :set_art, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show] # read only

  # POST /arts
  def create
    current_collection = Collection.find(art_params[:collection_id])
    author = current_collection.user_id
    if current_user.id == author
        new_art = Art.new(art_params)

      if new_art.save
        render json: new_art, status: :ok
      else
        render json: new_art.errors, status: :unprocessable_entity
      end
    else
      head :unauthorized
    end
  end

  # GET /arts
  def index
    render json: Art.all
  end

  # GET /arts/:id
  def show
    render json: @art
  end

  # PATCH/PUT /arts/1
  def update
    if @art.update(art_params)
      head :no_content
    else
      render json: @art.errors, status: :unprocessable_entity
    end
  end

  # DELETE /arts/1
  def destroy
    @art.destroy

    head :no_content
  end

  private

    def set_art
      @art = Art.find(params[:id])
    end

    def art_params
      params.require(:art).permit(:title, :caption, :image, :collection_id)
    end

    private :set_art, :art_params
end
