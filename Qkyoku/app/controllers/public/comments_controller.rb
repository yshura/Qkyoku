class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :monitoring, only: [:edit, :update, :destroy]
  before_action :prevent_url, only: [:edit, :update, :destroy]
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
    #@comments = Kaminari.paginate_array(@comments).page(params[:page]).per(10)
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
      redirect_to public_post_path(@post), notice: '投稿完了しました'
    else
      @status = ExecutionStatus.all
      render :new, notice:
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
      redirect_to public_post_path(@post), notice: 'コメントを更新しました'
    else
      @status = ExecutionStatus.all
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to public_post_path(@post), notice: 'コメントを削除しました'
  end
  
  private
  def comment_params
    params.require(:comment).permit(:execution_status_id, :image, :comment_body)
  end
  
  def monitoring
     @comment = Comment.find(params[:id])
  end

  def prevent_url
    if @comment.user_id != current_user.id
      redirect_to root_path
    end
  end
end
