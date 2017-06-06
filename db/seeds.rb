require 'faker'

skills = (0..7).map do
  skill_name = Faker::Job.unique.key_skill
  Skill.create(name: skill_name, description: "Description for #{skill_name} skill")
end

10.times do
  team = Team.create(
    name: Faker::Team.name,
    mission: Faker::Lorem.sentence,
    vision: Faker::Lorem.sentence
  )
  1000.times do
    employee = team.employees.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      identification: Faker::Code.isbn,
      active: true,
      description: Faker::Lorem.sentence,
      birthday: Faker::Date.birthday(18, 85),
      team: team
    )
    skills.shuffle.take(2).each do |skill|
      employee.employee_skills.create(skill: skill)
    end
  end
end

