require_relative 'vehicle'

class ParkingSpace
  attr_accessor :ticket_id, :vehicle

  def initialize(id)
    @ticket_id = id.to_i
    @vehicle = nil
  end

  def park(vehicle_number, vehicle_color)
    raise 'Vehicle is already there.' if vehicle
    self.vehicle = ::Vehicle.new(vehicle_number, vehicle_color)
  end

  def free
    raise 'Vehicle is not there.' unless vehicle
    self.vehicle = nil
  end

  def free?
    vehicle.nil?
  end

  def vehicle_number
    vehicle&.number
  end

  def vehicle_color
    vehicle&.color
  end
end
