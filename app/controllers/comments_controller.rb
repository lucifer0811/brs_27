class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @review = Review.find_by id: params[:review_id]
    unless @review.nil?
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
    else
      flash[:danger] = t "review not found"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:comment_id]
    unless @comment.nil?
      @comment.destroy
      flash[:success] = t "comment.delete_success"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t "comment.delete_failed"
    end
  end
  private
  def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to :back if @comment.nil?
    end
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :content
  end
end
