class Api::PostsController < Api::ApplicationController
  def index
    @posts = @user.post.includes(:author).order(id: :asc)
    
    render json: @posts, status: :ok
  end
end