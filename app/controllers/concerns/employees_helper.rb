module EmployeesHelper
  def employee_params
    params.permit(:first_name, :last_name, :identification, :active, :description, :birthday)
  end
end
