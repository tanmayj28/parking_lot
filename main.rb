require 'byebug'
require 'awesome_print'
require_relative 'src/models/parking_lot'

class ParkingSystem
  def initialize
    @parking_lot = nil
  end

  def process
    @parking_lot = ParkingLot.new(4)
    @parking_lot.park('01', 'white')
    @parking_lot.leave 0
    @parking_lot.park('01', 'white')
    @parking_lot.park('02', 'red')
    @parking_lot.park('03', 'white')
    @parking_lot.park('04', 'blue')
    puts "Parking Status:\n"
    @parking_lot.status
    puts "Reg Number for cars with color: White\n"
    @parking_lot.registration_numbers_for_cars_with_color 'white'
    puts "Ticket Number for cars with color: White\n"
    @parking_lot.ticket_numbers_for_cars_with_color 'white'
    puts "Ticket Number for car with number: 02\n"
    @parking_lot.ticket_number_for_car_with_number '02'
  end
end

begin
  ps = ParkingSystem.new
  ps.process
rescue NoMethodError => e
  puts "Error: #{e}"
rescue RuntimeError => e
  puts "Error: #{e}"
rescue => e
  puts "Error: #{e}"
end
