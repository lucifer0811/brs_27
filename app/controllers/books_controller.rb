class BooksController < ApplicationController
  before_action :load_book, only: :show
  before_action :check_book, only: :show

  def show
    @reviews = Review.all.order("created_at DESC").where(book_id: params[:id])
      .paginate(page: params[:page], per_page: Settings.users.per_page)
    @book_status = BookStatus.find_by book_id: @book.id, user_id: current_user.id
    if @book_status.nil?
      @book_status = current_user.book_statuses.new
      @book_status.book = @book
      @book_status.save
    end
  end

  def index
    if params[:search]
      @books = Book.search(params[:search]).order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.users.per_page
    else
      @books = Book.order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.users.per_page
    end
  end

  def create
    @book = Book.new book_params
    if @Book.save
      flash[:success] = t "book.book_create_success"
      redirect_to books_path
    else
      flash[:danger] = t "book.book_create_fail"
      render :new
    end
  end
  private

  def load_book
    @book = Book.find_by id: params[:id]
  end

  def check_book
    unless @book
      flash[:danger] = t "flash.no_object"
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit :title, :author, :publish_date, :number_of_page
      :category_id
  end
end
