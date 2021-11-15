require_relative '../../src/models/parking_lot'

RSpec.describe ParkingLot do
  describe 'initialize' do
    context 'valid input params' do
      it 'should return parking_lot instance' do
        parking_lot = ParkingLot.new('1')
        expect(parking_lot.parking_spaces.length).to eql(1)
      end

      it 'should allow to park vehicle if space present' do
        parking_lot = ParkingLot.new('1')
        parking_lot.park('01', 'White')
        expect(parking_lot.parking_spaces[0].vehicle_number).to eql('01')
        expect(parking_lot.parking_spaces[0].vehicle_color).to eql('White')
      end

      it 'should not allow to park if space not present' do
        parking_lot = ParkingLot.new('1')
        parking_lot.park('01', 'Black')
        expect do
          parking_lot.park('02', 'White')
        end.to raise_error(RuntimeError, 'Sorry! No parking space available.')
      end

      it 'should allow unparking and free a slot' do
        parking_lot = ParkingLot.new('1')
        parking_lot.park('01', 'White')
        parking_lot.leave(0)
        expect(parking_lot.parking_spaces[0].free?).to eql(true)
      end

      it 'should not allow unparking when car is not parked in slot' do
        parking_lot = ParkingLot.new('3')
        parking_lot.park('01', 'Red')
        expect do
          parking_lot.leave(2)
        end.to raise_error(RuntimeError, 'Vehicle is not there.')
      end

      it 'should returns Vehicle numbers' do
        parking_lot = ParkingLot.new(5)
        parking_lot.park('10', 'color')
        parking_lot.park('11', 'color1')
        parking_lot.park('12', 'color')
        parking_lot.park('13', 'color1')
        expect do
          parking_lot.registration_numbers_for_cars_with_color('color')
        end.to output("Vehicle Number\n10\n12\n").to_stdout
      end

      it 'returns car numbers' do
        parking_lot = ParkingLot.new(5)
        parking_lot.park('10', 'color')
        parking_lot.park('11', 'color1')
        parking_lot.park('12', 'color')
        parking_lot.park('13', 'color1')
        expect do
          parking_lot.ticket_numbers_for_cars_with_color('color')
        end.to output("Ticket Id\n0\n2\n").to_stdout
      end

      it 'returns car numbers' do
        parking_lot = ParkingLot.new(5)
        parking_lot.park('10', 'color')
        parking_lot.park('11', 'color1')
        parking_lot.park('12', 'color')
        parking_lot.park('13', 'color1')
        expect do
          parking_lot.ticket_numbers_for_cars_with_color('color1')
        end.to output("Ticket Id\n1\n3\n").to_stdout
      end
    end

    context 'invalid input paramaters' do
      it 'should throw exception' do
        expect { ParkingLot.new }.to raise_error(ArgumentError)
      end

      it 'should throw exception when parking details not provided' do
        parking_lot = ParkingLot.new('1')
        expect { parking_lot.park }.to raise_error(ArgumentError)
      end

      it 'should throw exception when unparking details not provided' do
        parking_lot = ParkingLot.new('1')
        expect { parking_lot.leave }.to raise_error(ArgumentError)
      end

      it 'should throw exception when registration_numbers_for_cars_with_color details not provided' do
        parking_lot = ParkingLot.new('1')
        expect { parking_lot.registration_numbers_for_cars_with_color }.to raise_error(ArgumentError)
      end

      it 'should throw exception when ticket_numbers_for_cars_with_color details not provided' do
        parking_lot = ParkingLot.new('1')
        expect { parking_lot.ticket_numbers_for_cars_with_color }.to raise_error(ArgumentError)
      end

      it 'should throw exception when ticket_numbers_for_cars_with_color details not provided' do
        parking_lot = ParkingLot.new('1')
        expect { parking_lot.ticket_numbers_for_cars_with_color }.to raise_error(ArgumentError)
      end

      it 'should log error when unpark slot is invalid' do
        parking_lot = ParkingLot.new('3')
        parking_lot.park('01', 'Red')
        expect do
          parking_lot.leave(22)
        end.to raise_error(RuntimeError, 'Please input valid params.')
      end

      it 'should return false and print nothing if colored car not present' do
        parking_lot = ParkingLot.new(5)
        parking_lot.park('10', 'color')
        parking_lot.park('11', 'color1')
        parking_lot.park('12', 'color')
        parking_lot.park('13', 'color1')
        parking_lot.registration_numbers_for_cars_with_color('color2').should be_falsy
      end

      it 'should return false and print nothing if colored car not present' do
        parking_lot = ParkingLot.new(5)
        parking_lot.park('10', 'color')
        parking_lot.park('11', 'color1')
        parking_lot.park('12', 'color')
        parking_lot.park('13', 'color1')
        parking_lot.ticket_numbers_for_cars_with_color('color2').should be_falsy
      end

      it 'should return false and print nothing if car number not present' do
        parking_lot = ParkingLot.new(5)
        parking_lot.park('10', 'color')
        parking_lot.park('11', 'color1')
        parking_lot.park('12', 'color')
        parking_lot.park('13', 'color1')
        parking_lot.ticket_number_for_car_with_number('15').should be_falsy
      end
    end
  end
end
