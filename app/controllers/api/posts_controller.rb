class Api::PostsController < Api::ApplicationController
  before_action :set_user
  before_action :set_posts

  def index
    # @posts = @user.post.includes(:author).order(id: :asc)
    
    render json: @posts, only: [:title, :text], status: :ok #api/users/1/posts
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_posts
    @posts = @user.post.includes(:author).order(id: :asc)
  end
end