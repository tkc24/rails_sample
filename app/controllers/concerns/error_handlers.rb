module ErrorHandlers
  extend ActiveSupport::Concern
  included do
    rescue_from Exception, with: :rescure500
    rescue_from ActionController::ParameterMissing, with: :rescure400
    rescue_from ApplicationController::Forbidden, with: :rescure403
    rescue_from ApplicationController::IpAddressRejected, with: :rescure403
    rescue_from ActionController::RoutingError, with: :rescure404
    rescue_from ActiveRecord::RecordNotFound, with: :rescure404
  end

  private
  def rescure400(e)
    @exception = e
    render 'errors/bad_request', status: 400
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
