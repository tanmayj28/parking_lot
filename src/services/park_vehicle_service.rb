require_relative 'application_service'

class ParkVehicleService < ApplicationService
  def process
    park_vehicle &&
      set_result
  end

  private

  def park_vehicle
    params[:parking_space].park(params[:vehicle_number], params[:vehicle_color])
  end
end
