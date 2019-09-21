class InternalApi::V1::LoginController < InternalApiController
  def login
    if params[:name] == 'admin' then
      succeed = Admin.all.find { |admin| admin.valid_password?(params[:password]) }.present?
    else
      succeed = Team.find_first_by_auth_conditions(login_name: params[:name])&.valid_password?(params[:password])
    end

    render json: { result: succeed ? 'success' : 'fail' }
  end
end
