class Public::FavoritesController < ApplicationController
  def index
    #@favorites = Favorite.where(user_id: current_user.id)
    @user = User.find(params[:user_id])
    @favorites = @user.favorites
  end
  
  def create
    @comment = Comment.find(params[:comment_id])
    @post = @comment.post
    favorite = current_user.favorites.new(comment_id: @comment.id)
    favorite.save
    logger.info favorite.errors.inspect
  end
  
  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = @comment.post
    favorite = current_user.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
  
  end
end
