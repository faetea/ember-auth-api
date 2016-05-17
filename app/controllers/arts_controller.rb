class ArtsController < ProtectedController
  before_action :set_author, only: [:create, :update]
  before_action :set_art, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show] # read only

  # POST /arts
  def create
    if current_user.id == @author
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

  # PATCH/PUT /arts/1
  def update
    if current_user.id == @author

      if @art.update_attributes(:title => art_params[:title], :caption => art_params[:caption])
        #  @art.update_attribute(:image, art_params[:image])
        render json: @art, status: :ok
      else
        render json: @art.errors, status: :unprocessable_entity
      end
    else
      head :unauthorized
    end
  end

  # DELETE /arts/1
  def destroy
    if current_user.id == @author
      @art.destroy
      head :no_content
    else
      head :unauthorized
    end
  end

  # GET /arts
  def index
    sortedArts = Art.order(updated_at: :desc)
    # => SELECT "arts".* FROM "arts" ORDER BY "arts"."updated_at" DESC
    render json: sortedArts
  end

  # GET /arts/:id
  def show
    render json: @art
  end

  private

    def set_art
      @art = Art.find(params[:id])
    end

    def set_author
      current_collection = Collection.find(art_params[:collection_id])
      @author = current_collection.user_id
    end

    def art_params
      params.require(:art).permit(:title, :caption, :image, :collection_id)
    end

    private :set_art, :set_author, :art_params
end
