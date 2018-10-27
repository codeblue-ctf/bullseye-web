class InternalApi::V1::AuthorizationController < InternalApiController
  def login
    if params[:name] == 'admin' then
      result = Admin.all.find { |admin| admin.valid_password?(params[:password]) }.present?
    else
      result = Team.find(login_name: params[:name]).valid_password?(params[:password])
    end

    { result: result }
  end
end
