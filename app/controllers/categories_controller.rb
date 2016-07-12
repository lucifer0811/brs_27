class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "flash.no_object"
      redirect_to categories_path
    end
  end

  def index
    @categories = Category.order(created_at: :asc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end
end
