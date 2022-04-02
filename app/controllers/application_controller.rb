class ApplicationController < ActionController::API
  rescue_from Utils::JsonError do |error_obj|
    render json: error_obj, status: error_obj.error_code
  end
end
