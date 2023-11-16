class Api::CommentsController < Api::ApplicationController
  def index
    @comments = @post.comments.order(create_at: :asc)
    render json: @comments, status: :ok
  end

  def create
    @comment = @post.comments.build(comment_params.merge(user: @user))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])

    unless @post
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end