class LocationsController < ApplicationController
  helper_method :filters_present?

  # GET /locations
  def index
    if location_present?
      @spaces = Space.near(params[:location], params[:distance])
      filter_spaces
      sort_spaces
    else
      @spaces = Space.all
    end
    paginate_spaces
    @hash = Location.load_space_markers(@spaces)
  end

  private

  def filters_present?
    params[:date_from].present? || params[:date_until].present? || params[:sort].present?
  end

  def filter_spaces
    @spaces = @spaces.filter_by(params[:date_from], params[:date_until], params[:available_weekend])
  end

  def sort_spaces
    @spaces = @spaces.sort_by(params[:sort])
  end

  def paginate_spaces
    @spaces = @spaces.paginate(page: params[:page], per_page: 5)
  end

  def location_present?
    params[:location].present? && params[:distance].present?
  end
end
