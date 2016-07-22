class LikesController < ApplicationController
  before_action :logged_in_user, :load_activity

  def index
  end

  def create
    @like = current_user.likes.create likes_params
    @activity = @like.activity
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    @activity = @like.activity
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def likes_params
    params.require(:like).permit :activity_id, :user_id
  end

  def load_activity
    @activity = Activity.find_by id: params[:like][:activity_id]
    if @activity.nil?
      flash[:success] = t "activity.no_activity"
      redirect_to root_path
    end
  end
end
