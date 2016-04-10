class ArtsController < ProtectedController
  before_action :set_art, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show] # read only

  # POST /arts
  def create
    @art = Art.new(art_params)

    if @art.save
      render json: @art, status: :created, location: @art
    else
      render json: @art.errors, status: :unprocessable_entity
    end
  end

  # GET /arts
  def index
    @arts = Art.all

    render json: @arts.as_json(only: [:id, :title, :caption, :image], include: [:collection])
  end

  # GET /arts/:id
  def show
    render json: @art.as_json(only: [:id, :title, :caption, :image], include: [:collection])
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
      params.permit(:title, :caption, :image)
    end

end
