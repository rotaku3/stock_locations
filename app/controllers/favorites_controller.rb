class FavoritesController < ApplicationController
     before_action :require_user_logged_in
  def create
    place = Place.find(params[:place_id])
    current_user.favorite(place)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    place = Place.find(params[:place_id])
    current_user.unfavorite(place)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
