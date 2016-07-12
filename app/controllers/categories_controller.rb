class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "flash.no_object"
      redirect_to categories_path
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "categories.create"
      redirect_to categories_path
    else
      flash[:danger] = t "categories.fail_create"
      render :new
    end
  end

  def index
    @categories = Category.order(created_at: :asc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  private
  def category_params
    params.require(:category).permit :category_name, :descriptions
  end
end
