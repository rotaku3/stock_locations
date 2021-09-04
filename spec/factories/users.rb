FactoryBot.define do
  factory :user do
    name { "テスト" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end