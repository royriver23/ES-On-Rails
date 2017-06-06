class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :team_id, :description, :identification, :birthday

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def birthday
    object.birthday&.strftime("%B %d, %Y")
  end
end
