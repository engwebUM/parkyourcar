class LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  # GET /locations
  def index
    if location_present?
      @spaces = Space.near(params[:location], params[:distance]).paginate(page: params[:page], per_page: 5)
    else
      @spaces = Space.all.paginate(page: params[:page], per_page: 5)
    end
    load_space_markers
  end

  private

  def location_present?
    params[:location].present?
  end

  def load_space_markers
    @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.infowindow space.address
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def location_params
  # params.require(:location).permit(:title, :description, :price, :address, :latitude, :longitude)
  # end
end
