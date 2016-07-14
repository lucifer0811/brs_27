class Admin::RequestsController<ApplicationController

  def show
    @requests=Request.all.order(updated_at: :desc).paginate page: params[:page]
  end
end
