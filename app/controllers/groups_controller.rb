class GroupsController < ApplicationController
  before_action :require_user_logged_in
  before_action :current_user, only:[ :new]
  before_action :group_correct_user, only:[:update,:destroy]
 

  def show
    @group = Group.find(params[:id])
    @pagy, @users = pagy(@group.invitation_users.order(id: :desc))
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      @invitation = current_user.invitations.create(group_id: @group.id,status: 'participated')
      @invitation.save
      flash[:success] = 'グループを作成しました。'
      redirect_to @group
    else
      flash.now[:danger] = 'グループの作成に失敗しました。'
      render :new
    end
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:success] = 'グループが更新されました'
      redirect_to @group
    else
      flash.now[:danger] = 'グループが更新されませんでした'
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = 'グループを削除しました。'
    redirect_to root_url
  end

  private
  def group_params
    params.require(:group).permit(:name,:public)
  end
  
  def group_correct_user
    @group = current_user.groups.find_by(id: params[:id])
    unless @group
      redirect_to root_url
    end
  end
end
