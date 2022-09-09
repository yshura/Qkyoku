class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    redirect_to public_posts_path(@post)
    else
    render "new"
    end
  end
  
  def show 
    @post = Post.find(params[:id])
    @comments = @post.comments
    # 既読未読機能
    # if Check.create(post_id: @post.id, user_id: current_user.id) 
    #   @check = Check.update(complete: true)
    # end
  end
  
  def edit
    @post = Post.find(params[:id])
    @sections = Section.all
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post)
    else
      @status = ExecutionStatus.all
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path(@post)
  end
  
  def search
    if params[:keyword].present?
      @posts = Post.where('caption LIKE ?', "%#{params[:keyword]}%")
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
