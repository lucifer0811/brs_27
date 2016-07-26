class Admin::UsersController < ApplicationController
  def show
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
        .paginate page: params[:page], per_page: Settings.users.per_page
    else
      @users = User.order(updated_at: :desc).paginate page: params[:page],
        per_page: Settings.users.per_page
    end
  end

  def destroy
    @user=User.find_by id:params[:id]
    unless @user.nil?
      @user.destroy
      flash[:success] = t "users.delete_success"
      redirect_to admin_users_url
    else
      flash[:danger] =t "flash.user_nil"
      redirect_to admin_users_url
    end
  end
end
