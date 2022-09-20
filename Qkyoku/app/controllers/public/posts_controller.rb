class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.page(params[:page]).per(10)
    if params[:latest]
      @posts = Post.all.latest.page(params[:page]).per(10)
    elsif params[:old]
      @posts = Post.all.old.page(params[:page]).per(10)
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    redirect_to public_posts_path(@post), notice: '投稿完了しました'
    else
    render 'new'
    end
  end
  
  def show 
    @user = current_user
    @post = Post.find(params[:id])
    @comments = @post.comments
    # 既読未読機能
    if Check.create(post_id: @post.id, user_id: current_user.id) 
       Check.update(complete: true)
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @sections = Section.all
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: '投稿内容を更新しました'
    else
      @status = ExecutionStatus.all
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_user_path(@post.user), notice: '投稿を削除しました'
  end
  
  def search
    if params[:keyword].present?
      @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :post_body, :image, :section_id)
  end
  
end
