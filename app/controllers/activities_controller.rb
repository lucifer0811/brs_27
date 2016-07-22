class ActivitiesController < ApplicationController
  def index
    @activities = Activity.order("created_at DESC").paginate page: params[:page],
      per_page: Settings.per_page
  end
  def show
    @activity = Activity.find_by id: params[:id]
  end
end
