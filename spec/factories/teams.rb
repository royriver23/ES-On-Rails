FactoryGirl.define do
  factory :team do
    name { Faker::Team.name }
    mission { Faker::Lorem.sentence(3) }
    vision { Faker::Lorem.sentence(3) }
  end
end
