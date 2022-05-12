class Cmd::Users::SignUp < Cmd::Base
  string :username
  string :password

  def execute
    User.create(username:, password:)
  rescue => e
    errors.add(:sign_up, e.message)
  end
end
