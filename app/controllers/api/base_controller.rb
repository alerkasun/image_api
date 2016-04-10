class Api::BaseController < ActionController::Base

  before_action :verify_access?, :header

  attr_reader :current_user

  def verify_access?
    begin
      request.env['HTTP_API_TOKEN'] =~ /^Token\s(.*)$/
      token = $1
      @current_user = User.find_by(api_token: token)
    rescue StandardError => ex
      response['APP_ERROR'] = ex.message
      response.status = 401; render nothing: true
    end
  end

  def header
    response['HTTP_API_TOKEN'] = "Token #{current_user.api_token}" and return if current_user
    response['HTTP_API_TOKEN'] = ""
  end

  def pars_ex( error )
    return false unless error.message =~ /^(.+)?\^\^\^(.+)$/
    {status: $1.to_i, error: $2}
  end

end
