FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    password { 'MyString' }
    api_token { SecureRandom.hex }
    balance { 0 }
  end
end
