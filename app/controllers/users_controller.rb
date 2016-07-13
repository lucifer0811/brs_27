class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :find_by_id, only: [:show, :update, :edit, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "static_pages.home_title"
      redirect_to login_url
    else
      render :new
    end
  end

  def edit
  end

  def index
    @users = User.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "page.update"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def find_by_id
    @user = User.find_by id: params[:id]
  end
end
