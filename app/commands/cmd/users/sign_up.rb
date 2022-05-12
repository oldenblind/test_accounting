class Cmd::Users::SignUp < Cmd::Base
  string :username
  string :password

  def execute
    user = User.new(username:, password:)

    user.save ? user : errors.add(:sig, user.errors.messages)
  end
end
