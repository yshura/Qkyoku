class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all.page(params[:page]).per(10)
    if params[:latest]
      @posts = Post.all.latest.page(params[:page]).per(10)
    elsif params[:old]
      @posts = Post.all.old.page(params[:page]).per(10)
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_path(@post.user)
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end