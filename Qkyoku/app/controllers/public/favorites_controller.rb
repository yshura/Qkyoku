class Public::FavoritesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @favorites = @user.favorites
    #binding.pry
    # @post = Post.find(params[:post_id])
  end
  
  def create
    @comment = Comment.find(params[:comment_id])
    @post = @comment.post
    favorite = current_user.favorites.new(comment_id: @comment.id)
    favorite.save
    @comment.create_notification_favorite(current_user)
    logger.info favorite.errors.inspect
  end
  
  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = @comment.post
    favorite = current_user.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
  end
end
