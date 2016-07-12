class BooksController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :load_book, only: :show
  before_action :check_book, only: :show

  def show
  end

  def index
    @books = Book.all.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.users.per_page
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
