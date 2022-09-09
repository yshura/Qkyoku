class Public::UsersController < ApplicationController
  
  def index
    @sections = Section.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path, notice: '更新しました'
    else
      render 'edit'
    end
  end
  
  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
