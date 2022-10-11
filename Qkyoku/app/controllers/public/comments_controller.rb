class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:new, :edit]

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
      @comment.create_notification_comment(current_user)
      redirect_to public_post_path(@post), notice: '投稿完了しました'
    else
      @status = ExecutionStatus.all
      render :new
    end
  end
  
  def edit
    session[:previous_url] = request.referer
    @comment = Comment.find_by(id: params[:id])
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
    redirect_to session[:previous_url], notice: 'コメントを削除しました'
  end
  
  private
  def comment_params
    params.require(:comment).permit(:execution_status_id, :image, :comment_body)
  end
  
  def ensure_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to public_post_path(params[:post_id]) , notice: 'ゲストユーザーはコメントできません'
    end
  end 
  
end
