class PostsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  before_action :find_post, only: [:show]
  before_action :initialize_like

  def index
    @posts = @user.post
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = @user.post.build
  end

  def create
    @post = Post.new(post_params)
    @post.author = @user

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created'
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def initialize_like
    @like = Like.new
  end
end
