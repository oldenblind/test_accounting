class Cmd::Users::SignIn < Cmd::Base
  string :username
  password :password

  def execute
    user.authenticate(password) || {}
  end

  private

  def user
    @user ||= User.find_by(username:)
  end
end
