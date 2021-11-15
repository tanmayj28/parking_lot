require_relative 'application_service'

class CreateParkingLotService < ApplicationService 
  def process
    create_parking_lot &&
      set_result
  end

  private
  attr_reader :parking_spaces

  def create_parking_lot
    @parking_spaces = []
    params[:size].to_i.times do |space|
      parking_spaces[space] = ParkingSpace.new(space)
    end
  end

  def set_result
    parking_spaces
  end
end
