class EmployeesController < ApplicationController
  include EmployeesHelper

  # GET /employees/:id
  def show
    json_response fetch_employee
  end

  # PUT /employees/:id
  def update
    fetch_employee.update employee_params
    head :no_content
  end

  # DELETE /employees/:id
  def destroy
    fetch_employee.destroy
    head :no_content
  end

  private

  def fetch_employee
    Employee.find params[:id]
  end

end
