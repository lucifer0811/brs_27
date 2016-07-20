class Admin::CategoriesController < ApplicationController
  before_action :is_admin, only: [:edit, :destroy]
  before_action :load_category, except: :index
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
    @categories = Category.order(created_at: :DESC).paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "categories.update"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "categories.fail_create"
      render :edit
    end
  end

  def edit
  end

  def destroy
    unless @category.books.any?
      if @category.destroy
        flash[:success] = t "flash.category_delete"
      else
        flash[:danger] = t "flash.fail_delete"
      end
    else
        flash[:danger] = t "flash.book_exsit"
    end
    redirect_to :back
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

  def is_admin
    redirect_to login_path unless current_user.is_admin?
  end
end
