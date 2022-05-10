class Api::V1::Users::SessionController < Api::V1::BaseController
  def create
    outcome = Cmd::Users::SignIn.run!(user_params)

    if outcome.valid?
      render_model outcome.result
    else
      render_errors outcome.erorrs.to_h
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
