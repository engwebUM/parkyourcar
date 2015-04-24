class FavoritesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_space, except: [:index]

  # GET /favorites
  def index
    @favorites = current_user.favorites.by_last_created.paginate(page: params[:page], per_page: 2)
  end

  def create
    if Favorite.create(space: @space, user: current_user)
      flash[:success] = 'Favorite was successfully created.'
      redirect_to @space
    else
      redirect_to @space
    end
  end

  def destroy
    Favorite.where(space_id: @space.id, user_id: current_user.id).first.destroy
    flash[:success] = 'Favorite was successfully removed.'
    redirect_to @space
  end

  private

  def set_space
    @space = Space.find(params[:space_id] || params[:id])
  end
end
