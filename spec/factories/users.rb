FactoryBot.define do
  factory :user do
    name { "ใในใ" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end