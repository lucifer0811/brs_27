class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @request = current_user.requests.build request_params
    if @request.save
      respond_to do |format|
        format.html do
          flash[:success] = t "request.created"
          redirect_to requests_path
        end
        format.js {@request_js = @request}
      end
    else
      flash[:success] = t "request.fail"
      redirect_to root_path
    end
  end

  def destroy
  end

  def show
    @user = current_user
    @requests = @user.requests.order(updated_at: :desc).paginate page: params[:page]
    @new_request = current_user.requests.build if logged_in?
  end

  private
  def request_params
    params.require(:request).permit :book_name
  end
end
