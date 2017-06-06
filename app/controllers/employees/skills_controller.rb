class Employees::SkillsController < ApplicationController

  # GET /employees/:employee_id/skills
  def index
    json_response fetch_employee.skills
  end

  private

  def fetch_employee
    Employee.find params[:employee_id]
  end
end
