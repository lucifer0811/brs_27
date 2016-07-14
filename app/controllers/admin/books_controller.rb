class Admin::BooksController < ApplicationController
  before_action :load_book, only: [:show, :update]
  before_action :load_categories, only: [:create, :new]

  def new
    @book = Book.new
  end

  def index
    @books = Book.all.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def create
    @book = Book.new book_params
    @book.category_id = params[:category_id]
    if @book.save
      flash[:success] = t "book.book_create_success"
      redirect_to admin_books_path
    else
      flash[:danger] = t "book.book_create_fail"
      render :new
    end
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "flash.success"
      redirect_to books_path(@book)
    else
      flash[:danger] = t "flash.fail"
      render :edit
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
  end

  def book_params
    params.require(:book).permit :title, :author, :publish_date,
      :number_of_page, :category_id
  end

  def load_categories
    @categories = Category.all
  end
end
