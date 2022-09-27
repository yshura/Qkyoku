class Public::UsersController < ApplicationController
  
  def index
    @sections = Section.all
    @workplaces = Workplace.where(is_checked: true)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(10)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: '更新しました'
    else
      redirect_to public_user_path(@user), notice: '名前を入力してください'
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
    params.require(:user).permit(:name)
  end
  
end
