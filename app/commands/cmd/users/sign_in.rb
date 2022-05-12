class Cmd::Users::SignIn < Cmd::Base
  string :username
  password :password

  class IncorrectCredentials < StandardError; end

  def execute
    authenticated_user = user.authenticate(password)
    raise IncorrectCredentials, 'Invalid credentials' unless authenticated_user
  rescue IncorrectCredentials => e
    errors.add(:sign_in, e.message)
  end

  private

  def user
    @user ||= User.find_by(username:)
  end
end
