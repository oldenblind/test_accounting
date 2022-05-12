class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate!, only: :index

  def index
    render_model current_user
  end

  def create
    outcome = Cmd::Users::SignUp.run(user_params)

    if outcome.valid?
      render_model outcome.result
    else
      render_errors outcome.errors.to_hash
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
