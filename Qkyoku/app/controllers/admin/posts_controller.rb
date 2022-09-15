class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path(@post)
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end