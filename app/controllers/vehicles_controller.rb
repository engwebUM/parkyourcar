class VehiclesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_vehicle, only: [:edit, :update, :destroy]
  before_action :set_vehicles, only: [:index, :edit]

  def index
    @vehicle = Vehicle.new
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

  def edit
    render :index
  end

  def update
    if @vehicle.update(vehicle_params)
      flash[:success] = 'Vehicle was successfully edited.'
      redirect_to vehicles_path
    else
      render :edit
    end
  end

  def destroy
    @vehicle.destroy
    flash[:success] = 'Vehicle was successfully destroyed.'
    redirect_to vehicles_path
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:plate, :make, :model)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def set_vehicles
    @vehicles = current_user.vehicles.paginate(page: params[:page], per_page: 5)
  end
end
