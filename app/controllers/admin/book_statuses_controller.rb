class Admin::BookStatusesController < ApplicationController

  def create
    @book_status = current_user.book_statuses.build book_status_params
    unless @book_status.nil?
      if @book_status.save
        respond_to do |format|
          format.html do
            flash[:success] = t "book_status.create_success"
            redirect_to :back
          end
          format.js
        end
      else
        flash[:danger] = t "book_status.create_failed"
      end
    else
      flash[:danger] = t "book_status.not_found"
    end
  end

  def update
    @book_status = BookStatus.find_by book_id: params[:book_status][:book_id],
      user_id: params[:book_status][:user_id]
    unless @book_status.nil?
      if @book_status.update_attributes book_status_params
        respond_to do |format|
          format.html do
            flash[:success] = t "book_status.update_success"
            redirect_to :back
          end
          format.js do
            @book = Book.find_by id: @book_status.book_id
          end
        end
      else
        flash[:danger]  = t "book_status.update_failed"
      end
    else
      flash[:danger] = t "book_status.not_found"
    end
  end

  private
  def book_status_params
    params.require(:book_status).permit :reading_status, :is_favorite
  end
end
