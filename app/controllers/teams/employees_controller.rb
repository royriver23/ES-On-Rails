class Teams::EmployeesController < ApplicationController
  include EmployeesHelper
  include Searchable

  # GET /teams/:team_id/employees
  def index
    json_response search(fetch_team.employees)
  end

  # POST /teams/:team_id/employees
  def create
    employee = fetch_team.employees.create! employee_params
    json_response(employee, :created)
  end

  private

  def fetch_team
    Team.find params[:team_id]
  end

end
