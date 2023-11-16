class Api::CommentsController < Api::ApplicationController
    before_action :set_post

    def index
      @comments = @post.comment.order(created_at: :asc)
      render json: @comments, only: [:text], status: :ok
    end
  
    def create
      @comment = @post.comment.build(comment_params.merge(user: @user))
  
      if @comment.save
        render json: @comment, status: :created
      else
        render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
  
      unless @post
        render json: { error: 'Post not found' }, status: :not_found
      end
    end
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
  