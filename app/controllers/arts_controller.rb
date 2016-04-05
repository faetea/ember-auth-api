class ArtsController < ApplicationController
  before_action :set_art, only: [:show, :update, :destroy]

  # GET /arts
  def index
    @arts = Art.all

    render json: @arts
  end

  # GET /arts/1
  def show
    render json: @art
  end

  # POST /arts
  def create
    @art = Art.new(art_params)

    if @art.save
      render json: @art, status: :created, location: @art
    else
      render json: @art.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /arts/1
  def update
    @art = Art.find(params[:id])

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
      params[:art]
    end
end
