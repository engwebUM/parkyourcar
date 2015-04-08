class SpacesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  before_filter :require_permission, only: :edit

  def require_permission
    return unless current_user != Space.find(params[:id]).user
    redirect_to root_path
  end

  # GET /spaces
  def index
    @spaces = current_user.spaces.paginate(page: params[:page], per_page: 1)
  end

  # GET /spaces/1
  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  def create
    @space = Space.new(space_params)
    @space.user = current_user
    if @space.save
      flash[:success] = 'Space was successfully created.'
      redirect_to @space
    else
      render :new
    end
  end

  # PATCH/PUT /spaces/1
  def update
    if @space.update(space_params)
      flash[:success] = 'Space was successfully created.'
      redirect_to @space
    else
      render :edit
    end
  end

  # DELETE /spaces/1
  def destroy
    @space.destroy
    flash[:success] = 'Space was successfully destroyed.'
    redirect_to spaces_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def space_params
    params.require(:space).permit(:title, :available_spaces, :description, :country, :city, :address, :post_code, :price_hour, :price_week, :price_month, :date_from, :date_until, :available_weekend, :latitude, :longitude)
  end
end