class Public::CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end
  
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @status = ExecutionStatus.all
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to public_post_path(@post)
    else
      @status = ExecutionStatus.all
      render :new
    end
  end
  
  def show
  end
  
  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    @status = ExecutionStatus.all
  end
  
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to public_post_path(@post)
    else
      @status = ExecutionStatus.all
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to public_post_path(@post)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:execution_status_id, :image, :comment_body)
  end
end