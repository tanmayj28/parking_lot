require_relative 'application_service'

class ParkingStatusService < ApplicationService 
  def process
    get_parking_status &&
      set_result
  end

  private
  attr_reader :parking_spaces

  def get_parking_status
    @parking_spaces = []
    params[:parking_spaces].each do |space|
      parking_spaces << {
        ticket_id: space.ticket_id,
        vehicle_number: space.vehicle_number,
        vehicle_color: space.vehicle_color
      } unless space.free?
    end
  end

  def set_result
    headers = ["Ticket ID", "Registration No", "Color"]
    PrettyOutput.print(headers, parking_spaces)
  end
end
