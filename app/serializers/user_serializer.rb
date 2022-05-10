class UserSerializer
  include JSONAPI::Serializer
  attributes :balance, :username, :api_token
end
