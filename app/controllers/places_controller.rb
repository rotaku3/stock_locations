class PlacesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

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
    params.require(:place).permit(:name, :address, :datetime, :content)
  end
  
  
end
