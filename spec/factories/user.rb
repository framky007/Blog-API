FactoryBot.define do
  factory :user do
    sequence(:uuid) { |n| "YTHBERLO #{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    gender "Male"
    role "Admin"
    paassword 'pass'
  end
end
