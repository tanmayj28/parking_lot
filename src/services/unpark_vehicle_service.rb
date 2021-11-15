require_relative 'application_service'

class UnparkVehicleService < ApplicationService 
  def process
    raise 'Please input valid params.' unless valid_params?
    unpark_vehicle &&
      set_result
  end

  private

  def unpark_vehicle
    params[:parking_spaces][params[:parking_space]].free
  end

  def valid_params?
    params[:parking_spaces].count >= params[:parking_space]
  end
end
