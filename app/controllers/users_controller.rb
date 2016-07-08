class UsersController < ApplicationController
  def show
    @user = User.find_by params[:id]
  end

  def new
    @user = User.new
  end
end
