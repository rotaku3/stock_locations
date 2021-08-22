class PlacesController < ApplicationController
  before_action :require_user_logged_in
  before_action :place_correct_user, only: [:destroy]
  before_action :set_locale

  def new
    @place = Place.new
  end
  
  def create
    @place = current_user.places.build(place_params)
    if @place.save
      flash[:success] = '撮影地を投稿しました。'
      redirect_to root_url
    else
      @pagy, @places = pagy(current_user.places.order(id: :desc))
      flash.now[:danger] = '撮影地の投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @place = Place.find(params[:id])
  end
  
  def update
    @place = Place.find(params[:id])

    if @place.update(place_params)
      flash[:success] = '投稿は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @place.destroy
    flash[:success] = '撮影地を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def place_params
    params.require(:place).permit(:name, :address, :datetime, :image, :image_cache, :remove_image ,:latitude, :longitude, :content)
  end
  
  def place_correct_user
    @place = current_user.places.find_by(id: params[:id])
    unless @place
      redirect_to root_url
    end
  end
  
  def set_locale
    I18n.locale = :ja
  end
end
