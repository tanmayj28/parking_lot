require_relative 'parking_space'
require_relative 'vehicle'
require_relative '../services/create_parking_lot_service'
require_relative '../services/find_free_parking_space_service'
require_relative '../services/find_car_service'
require_relative '../services/park_vehicle_service'
require_relative '../services/unpark_vehicle_service'
require_relative '../services/parking_status_service'

class ParkingLot
  attr_reader :parking_spaces, :size

  def initialize(size)
    @size = size
    @parking_spaces = create_parking_lot

    puts "Your car parking lot with #{parking_spaces.count} spaces is ready."
  end

  def park vehicle_number, vehicle_color
    @vehicle_number, @vehicle_color = vehicle_number, vehicle_color
    validate_vehicle_parking &&
      park_vehicle
  end

  def leave occupied_parking_space
    @occupied_parking_space = occupied_parking_space
    unpark_vehicle
  end

  def status
    parking_status
  end

  def registration_numbers_for_cars_with_color search_val
    @search_for = search_val
    @search_by = 'color'
    @searchable = 'vehicle_number'
    find_car
  end

  def ticket_number_for_car_with_number search_val
    @search_for = search_val
    @search_by = 'number'
    @searchable = 'ticket_id'
    find_car
  end

  def ticket_numbers_for_cars_with_color search_val
    @search_for = search_val
    @search_by = 'color'
    @searchable = 'ticket_id'
    find_car
  end

  private
  attr_reader :vehicle_number, :vehicle_color, :free_parking_space, :occupied_parking_space, :search_by, :search_for, :searchable, :printable

  def create_parking_lot
    create_parking_lot_service = CreateParkingLotService.new({size: size})
    create_parking_lot_service.process
  end

  def find_free_parking
    find_free_parking_service = FindFreeParkingSpaceService.new(parking_spaces_params)
    find_free_parking_service.process
  end

  def validate_vehicle_parking
    free_parking_space_available? &&
      vehicle_already_present?
  end

  def free_parking_space_available?
    @free_parking_space = find_free_parking
    raise 'Sorry! No parking space available.' unless free_parking_space
    true
  end

  def vehicle_already_present?
    raise "The vehicle no: #{vehicle_number} is already parked." if ticket_number_for_car_with_number(vehicle_number)
    true
  end

  def park_vehicle
    park_vehicle_service = ParkVehicleService.new(park_vehicle_params)
    park_vehicle_service.process
  end

  def unpark_vehicle
    unpark_vehicle_service = UnparkVehicleService.new(unpark_vehicle_params)
    unpark_vehicle_service.process
  end

  def parking_status
    parking_status_service = ParkingStatusService.new(parking_spaces_params)
    parking_status_service.process
  end

  def find_car
    find_car_service = FindCarService.new(find_car_params)
    find_car_service.process
  end

  def parking_spaces_params
    {
      parking_spaces: parking_spaces
    }
  end

  def park_vehicle_params
    {
      vehicle_number: vehicle_number, 
      vehicle_color: vehicle_color, 
      parking_space: free_parking_space
    }
  end

  def unpark_vehicle_params
    {
      parking_spaces: parking_spaces,
      parking_space: occupied_parking_space
    }
  end

  def find_car_params
    {
      parking_spaces: parking_spaces,
      search_by: search_by,
      search_for: search_for,
      searchable: searchable,
    }
  end
end
