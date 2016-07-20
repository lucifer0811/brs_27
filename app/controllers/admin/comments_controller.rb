class Admin::CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_review, :load_comment

  def create
    @comment = @review.comments.build comment_params
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html do
          redirect_to :back
        end
        format.js
        flash[:success] = t "comment.success"
      end
    else
      @new_comment = @comment
      respond_to do |format|
        format.html do
          flash[:danger] = t "comment.failed"
          redirect_to :back
        end
        format.js do
          render action: "failed_save"
        end
      end
    end
  end

  def destroy
    if correct_user? @comment.user || current_user.is_admin?
      if @comment.destroy
        flash[:success] = t "comment.delete_success"
      else
        flash[:danger] = t "comment.delete_failed"
      end
    else
      flash[:danger] = t "user.not_owner"
    end
    redirect_to :back
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t "comment.success"
    else
      flash[:success] = t "comment.fail_update"
    end
    redirect_to @comment.review
  end

  private
  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment.nil?
      flash[:danger] = t "flash.no_object"
      redirect_to :back
    end
  end
  def load_review
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:danger] = t "flash.no_object"
      redirect_to admin_book_review_path(@review)
    end
  end
  def correct_user? user
    current_user == user
  end
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :content
  end
end
