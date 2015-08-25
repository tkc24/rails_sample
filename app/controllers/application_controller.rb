class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  rescue_from Exception, with: :rescure500
  rescue_from Forbidden, with: :rescure403
  rescue_from IpAddressRejected, with: :rescure403
  rescue_from ActionController::RoutingError, with: :rescure404
  rescue_from ActiveRecord::RecordNotFound, with: :rescure404

  private
  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

  def rescure404(e)
    @exception = e
    render 'errors/not_found', status: 404
  end

  def rescure403(e)
    @exception = e
    render 'errors/forbidden', status: 403
  end

  def rescure500(e)
    @exception = e
    render 'errors/internal_server_error', status: 500
  end

end
