class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  
 
  def show
    @user = User.find(params[:id])
    @pagy, @places = pagy(@user.places.order(id: :desc), items: 5)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings, items: 10)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers, items: 10)
    counts(@user)
  end
  
  def favorites
    @user = User.find(params[:id])
    @pagy, @favorites = pagy(@user.favorite_places.order(id: :desc), items: 5)
    counts(@user)
  end
  
  def search
    if params[:search_keyword].present?
      @pagy, @users = pagy(User.where('name LIKE ?', "%#{params[:search_keyword]}%"), items: 10)
    else
      @users = User.none
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
  
end