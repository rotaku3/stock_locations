class InvitationsController < ApplicationController
    before_action :require_user_logged_in
    
  def create
    user = User.find(params[:user_id])
    current_user.invitation(user)
    flash[:success] = 'ユーザを招待しました'
    redirect_to user
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    flash[:success] = 'ユーザのフォローを解除しました。'
    redirect_to user
  end
end
