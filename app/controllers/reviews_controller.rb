class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
  end

  def show
    @review = Review.find_by id: params[:id]
      flash[:danger] = t "flash.no_review" unless @review
    @comments = @review.comments.most_recent.paginate page: params[:page]
  end


  def create
    @review = Review.new review_params
    @review.user = User.find_by id: params[:user_id]
    @review.book = Book.find_by id: params[:book_id]
    if @review.save
      flash[:success] = t "flash.review_create_success"
    else
      flash[:danger] = t "flash.review_create_fail"
    end
    redirect_to :back
  end

  def update
  end

  def destroy
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :book_id, :user_id
  end
end
