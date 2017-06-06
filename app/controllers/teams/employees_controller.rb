class Teams::EmployeesController < ApplicationController
  include EmployeesHelper
  include Searchable

  # GET /teams/:team_id/employees
  def index
    # json_response search(fetch_team.employees)
    json_response Employee.where(id: employee_ids).order(updated_at: :desc)
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

  def employee_ids
    ::EmployeesIndex.searcher.get_ids(team_id: fetch_team.id, search_text: search_param)
  end

end
