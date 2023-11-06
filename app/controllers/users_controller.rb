class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    render 'show'
  end
end
