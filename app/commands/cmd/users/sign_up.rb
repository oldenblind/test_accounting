class Cmd::Users::SignUp < Cmd::Base
  string :username
  string :password

  def execute
    User.create(username:, password:)
  end
end
