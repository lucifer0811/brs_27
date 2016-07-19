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
    @comment = Comment.find_by id: params[:id]
    unless @comment.nil?
      if correct_user? @comment.user || current_user.is_admin?
        if @comment.destroy
          flash[:success] = t "comment.delete_success"
        else
          flash[:danger] = t "comment.delete_failed"
        end
      else
        flash[:danger] = t "user.not_owner"
      end
    else
      flash[:danger] = t "comment.not_found"
    end
    redirect_to :back
  end

  private
  def correct_user? user
    current_user == user
  end
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :content
  end
end
