class Admin::UsersController < ApplicationController
  def show
  end

  def index
    @users = User.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def destroy
    @user=User.find_by id:params[:id]
    unless @user.nil?
      @user.destroy
      flash[:success] = t "users.delete_success"
      redirect_to admin_users_url
    else
      flash[:notice] =t "flash.user_nil"
      redirect_to admin_users_url
    end
  end
end
