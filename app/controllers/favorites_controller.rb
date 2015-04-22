class FavoritesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  # GET /favorites
  def index
    @favorites = current_user.favorites.paginate(page: params[:page], per_page: 2)
  end

  def create
    set_space
    if Favorite.create(space: @space, user: current_user)
      flash[:success] = 'Favorite was successfully created.'
      redirect_to @space
    else
      redirect_to @space
    end
  end

  def destroy
    set_space
    Favorite.where(space_id: @space.id, user_id: current_user.id).first.destroy
    flash[:success] = 'Favorite was successfully removed.'
    redirect_to @space
  end

  private

  def set_space
    @space = Space.find(params[:space_id] || params[:id])
  end
end
