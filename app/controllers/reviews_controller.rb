class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update]
  before_action :find_book
  before_action :find_review, only: [:update, :destroy]

  def index
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find_by id: params[:id]
      flash[:danger] = t "flash.no_review" unless @review
      @comments = @review.comments.most_recent.paginate page: params[:page]
    if logged_in?
      @comment = current_user.comments.build
    end
  end


  def create
    @review = Review.new review_params
    @review.book = Book.find_by id: params[:book_id]
    @review.user = current_user
    if @review.save
      flash[:success] = t "flash.review_create_success"
      redirect_to book_path @book
    else
      flash[:danger] = t "flash.review_create_fail"
      render :new
    end
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "review.updated"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "review.noUpdate"
      redirect_to book_path(@book)
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "review.success"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "review.fail"
    end
  end

  private

  def review_params
    params.require(:review).permit :rating, :title, :content, :book_id, :user_id
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
  end

  def find_review
    @review = Review.find_by id: params[:id]
  end
end
