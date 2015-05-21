class VehiclesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @vehicles = current_user.vehicles
    paginate_vehicles
    @vehicle = Vehicle.new
  end

  def show
  end

  def new
    @vehicles = current_user.vehicles
    paginate_vehicles
    @vehicle = Vehicle.new
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    @vehicles = current_user.vehicles
    paginate_vehicles
    render :index
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user = current_user
    if @vehicle.save
      flash[:success] = 'Vehicle was successfully created.'
      redirect_to vehicles_path
    else
      render :new
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      flash[:success] = 'Vehicle was successfully edited.'
      redirect_to vehicles_path
    else
      render :edit
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    flash[:success] = 'Vehicle was successfully destroyed.'
    redirect_to vehicles_path
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:plate, :make, :model)
  end

  def paginate_vehicles
    @vehicles = @vehicles.paginate(page: params[:page], per_page: 2)
  end
end
