class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
  end

  def index
    @categories = Category.order(created_at: :asc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end
end
