class Cmd::Users::SignUp < Cmd::Base

  string :username
  string :password

  def execute
    User.create(username: username, password: password)
  end

end