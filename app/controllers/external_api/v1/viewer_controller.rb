class ExternalApi::V1::ViewerController < ExternalApiController
  def teams
    render json: { result: 'test' }
  end

  def problems
    render json: { result: 'test' }
  end
end
