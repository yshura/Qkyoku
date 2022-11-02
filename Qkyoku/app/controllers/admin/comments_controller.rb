class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.all.page(params[:page]).per(10)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_user_comments_path(@user)
  end
end