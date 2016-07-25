class CategoriesController < ApplicationController
  def index
    @categories = Category.order(created_at: :asc).paginate page: params[:page],
      per_page: Settings.users.per_page
    @books = Book.all
  end
  def show
    @category = Category.all.find_by id: params[:id]
    @books = @category.books
  end
end
