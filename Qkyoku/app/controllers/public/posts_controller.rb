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
    end
    
    def edit
    end
    
    def update
    end
    
    private
    def post_params
      params.require(:post).permit(:title, :post_body, :image, :section_id)
    end
    
end
