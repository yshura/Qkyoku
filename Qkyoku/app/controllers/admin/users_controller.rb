class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: '更新しました'
    else
      redirect_to edit_admin_user_path(@user)
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email,:is_deleted)
    end
end
