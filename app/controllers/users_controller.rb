class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :find_user, except: [:create, :new, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_activity, only: :show

  def show
    @book_statuses= @user.book_statuses
    @favorite_books = []
    @read_books = []
    @reading_books = []

    @book_statuses.filter_favorite.each do |book_status|
      @favorite_books.push(Book.find_by id: book_status.book_id)
    end

    @book_statuses.book_read.each do |book_status|
      @read_books.push(Book.find_by id: book_status.book_id)
    end

    @book_statuses.book_reading.each do |book_status|
      @reading_books.push(Book.find_by id: book_status.book_id)
    end
    @activities = @user.activities.order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.users.per_page

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "static_pages.home_title"
      redirect_to books_path
    else
      render :new
    end
  end

  def edit
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

  def update
    if @user.update_attributes user_params
      flash[:success] = t "page.update"
      redirect_to @user
    else
      render :edit
    end
  end

  def following
    @title = "Following"
    find_user
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = "Followers"
    find_user
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"

  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user.not_found"
      redirect_to :back
    end
  end

  def load_activity
    @activity = Activity.find_by id: params[:id]
  end
end
