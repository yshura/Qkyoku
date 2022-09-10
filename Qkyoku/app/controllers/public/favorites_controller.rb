class Public::FavoritesController < ApplicationController
  def index
    #@favorites = Favorite.where(user_id: current_user.id)
    @user = User.find(params[:user_id])
    @favorites = @user.favorites
  end
  
  def create
    comment = Comment.find(params[:comment_id])
    favorite = current_user.favorites.new(comment_id: comment.id)
    favorite.save
    redirect_to public_post_path(params[:post_id]) 
  end
  
  def destroy
    comment = Comment.find(params[:comment_id])
    favorite = current_user.favorites.find_by(comment_id: comment.id)
    favorite.destroy
    redirect_to public_post_path(params[:post_id]) 
  end
end
