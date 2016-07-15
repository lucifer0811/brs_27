class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :find_book

  def index
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find_by id: params[:id]
      flash[:danger] = t "flash.no_review" unless @review
    @comments = @review.comments.most_recent.paginate page: params[:page]
  end


  def create
    @review = Review.new review_params
    if @review.save
      flash[:success] = t "flash.review_create_success"
      redirect_to book_path @book
    else
      flash[:danger] = t "flash.review_create_fail"
      redirect_to :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit :rating, :title, :content, :book_id, :user_id
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
  end
end
