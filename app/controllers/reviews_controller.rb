class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
  end

  def show
    @review = Review.find_by id: params[:id]
      flash[:danger] = t "flash.no_review" unless @review

  end


  def create
    @review = Review.new review_params
    if @review.save
      flash[:success] = t "flash.review_create_success"
    else
      flash[:danger] = t "flash.review_create_fail"
    end
  end

  def update
  end

  def destroy
  end

  private
  def review_params
    params.require(:reivew).permit :content, :book_id, :user_id
  end



end
