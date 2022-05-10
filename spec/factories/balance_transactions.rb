FactoryBot.define do
  factory :balance_transaction do
    target { Faker::Movies::Ghostbusters.quote }
    delta { 100_000 }
    user { create(:user) }
  end
end
