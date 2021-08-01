class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 10)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @places = pagy(current_user.places.order(id: :desc))
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
  
  def participated
    @user = User.find(params[:id])
    @pagy, @participated = pagy(@user.participated_groups)
    
  end
  
  def inviting
    @user = User.find(params[:id])
    @pagy, @inviting = pagy(@user.inviting_groups)
    
  end
  
  def search
    if params[:search_keyword].present?
      @users = User.where('name LIKE ?', "%#{params[:search_keyword]}%")
    else
      @users = User.none
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end