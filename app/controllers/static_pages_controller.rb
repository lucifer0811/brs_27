class StaticPagesController < ApplicationController
  def home
    @activities = Activity.order("created_at desc").paginate page: params[:page],
      per_page: Settings.per_page
  end

  def help
  end

  def contact
  end

  def about
  end
end
