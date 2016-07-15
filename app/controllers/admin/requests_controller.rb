class Admin::RequestsController<ApplicationController
before_action :logged_in_user, only: [:show]
before_action :check_admin, only: [:show, :destroy]

  def show
    @requests=Request.all.order(updated_at: :desc).paginate page: params[:page]
  end

  def destroy
    @request=Request.find_by id: params[:id]
    unless @request.nil?
      @request.destroy
      flash[:success]= t "request.destroyed"
    else
      flash[:notice]= t "request.not_destroyed"
    end
    redirect_to admin_requests_path
  end
end
