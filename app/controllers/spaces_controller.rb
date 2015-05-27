class SpacesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  before_filter :require_permission, only: :edit

  def require_permission
    return unless current_user != Space.find(params[:id]).user
    redirect_to root_path
  end

  # GET /spaces
  def index
    @spaces = current_user.spaces.by_last_created.paginate(page: params[:page], per_page: 2)
  end

  # GET /spaces/1
  def show
    @hash = Location.load_space_markers(@space)
    space_fill
  end

  # GET /spaces/new
  def new
    @space = Space.new
    @attachment = @space.attachments.build
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  def create
    @space = Space.new(space_params)
    @space.user = current_user
    if @space.save
      create_attachments
      flash[:success] = 'Space was successfully created.'
      redirect_to @space
    else
      render :new
    end
  end

  # PATCH/PUT /spaces/1
  def update
    if @space.update(space_params)
      create_attachments
      flash[:success] = 'Space was successfully updated.'
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
    params.require(:space).permit(:title, :available_spaces, :description, :country, :city, :address, :post_code, :price_hour, :price_week, :price_month, :date_from, :date_until, :available_weekend, :latitude, :longitude, attachments_attributes: [:id, :space_id, :file_name])
  end

  def create_attachments
    params[:attachments_new]['file_name'].each do |a|
      @attachment = @space.attachments.create!(file_name: a, space_id: @space.id)
    end unless params[:attachments_new].nil?
  end

  def space_fill
    @bookings = bookings_accepted.by_datetime_until.paginate(page: params['booking_page'], per_page: 5)
    @reviews = @space.reviews.paginate(page: params['review_page'], per_page: 5)
    @booked_by_user = @space.bookings.joins(:user).exists?(user_id: current_user)
    @user_already_reviewed = user_already_reviewed?
  end

  def bookings_accepted
    @space.bookings.where('state = ? AND date_until >= ?', BookingsController::ACCEPTED_STATE, DateTime.now.to_date)
  end

  def user_already_reviewed?
    @space.reviews.where(user: current_user).exists?
  end
end
