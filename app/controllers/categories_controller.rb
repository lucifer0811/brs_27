class CategoriesController < ApplicationController
  def index
    if params[:search]
      @categories = Category.search(params[:search]).order("updated_at DESC")
      .paginate page: params[:page], per_page: Settings.users.per_page
    else
      @categories = Category.order("updated_at DESC").paginate page: params[:page],
      per_page: Settings.users.per_page
    end
    @books = Book.all
  end
  def show
    @category = Category.all.find_by id: params[:id]
    @books = @category.books
  end
end
