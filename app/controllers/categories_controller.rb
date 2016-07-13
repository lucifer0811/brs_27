class CategoriesController < ApplicationController
  def index
    @categories = Category.order(created_at: :asc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end
end
