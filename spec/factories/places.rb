FactoryBot.define do
  factory :place do
    name { "安来" }
    user_id {FactoryBot.create(:user).id}
    address {"島根県安来市"}
    latitude {"35.4309827"}
    longitude {"133.2510947"}
    content {"test"}
    datetime {"2021-08-07T01:19"}
  end
end