class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:show, :edit, :update]
  before_action :check_category, only: :show

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "categories.create"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "categories.fail_create"
      render :new
    end
  end

  def index
    @categories = Category.order(created_at: :asc).paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "categories.update"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "categories.fail_create"
      redirect_to :edit
    end
  end

  def edit
  end

  private
  def category_params
    params.require(:category).permit :category_name, :descriptions
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end

  def check_category
    unless @category
      flash[:danger] = t "flash.no_object"
      redirect_to admin_categories_path
    end
  end
end
