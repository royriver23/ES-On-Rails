FactoryGirl.define do
  factory :skill do
    name { Faker::Job.key_skill }
    description { Faker::Lorem.sentence(3) }
  end
end
