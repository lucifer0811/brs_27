class UserRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    unless @user.nil?
      current_user.follow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "flash.user_nil"
    end

  end

  def destroy
    @user = UserRelationship.find_by(id: params[:id]).followed
    unless @user.nil?
      current_user.unfollow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "flash.user_nil"
    end
  end
end
