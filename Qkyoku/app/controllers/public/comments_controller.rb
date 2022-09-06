class Public::CommentsController < ApplicationController
    def index
        @comments = Comment.all
    end
    
    def new
        @comment = Comment.new
    end
    
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.save
        redirect_to public_posts_path
    end
    
    def show
    end
    
    def edit
    end
    
    def update
    end
    
    private
    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :exection_status_id, :comment_body)
    end
end
