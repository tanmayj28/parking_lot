# frozen_string_literal: true

require_relative '../../src/models/parking_space'

RSpec.describe ParkingSpace do
  describe 'initialize' do
    context 'valid input params' do
      it 'should return parking_space instance' do
        parking_space = ParkingSpace.new('1')
        expect(parking_space.class).to eql(ParkingSpace)
        expect(parking_space.ticket_id).to eql(1)
      end
    end

    context 'invalid input params' do
      it 'should throw exception' do
        expect { ParkingSpace.new }.to raise_error(ArgumentError)
      end
    end

    context 'free parking_space' do
      it 'should set vehicle as nil' do
        parking_space = ParkingSpace.new('1')
        parking_space.vehicle = Vehicle.new(1,'color')
        parking_space.free
        expect(parking_space.vehicle).to eql(nil)
      end
    end

    context 'check parking_space' do
      it 'should return true for free parking_space' do
        parking_space = ParkingSpace.new('1')
        expect(parking_space.free?).to eql(true)
      end

      it 'should return false for alotted parking_space' do
        parking_space = ParkingSpace.new('1')
        parking_space.park('01', 'White')
        expect(parking_space.free?).to eql(false)
      end
    end

    context 'get vehicle details' do
      it 'should give nil if no vehicle alloted' do
        parking_space = ParkingSpace.new('1')
        expect(parking_space.vehicle_number).to eql(nil)
        expect(parking_space.vehicle_color).to eql(nil)
      end

      it 'should give vehicle details if vehicle alloted' do
        parking_space = ParkingSpace.new('1')
        parking_space.park('01', 'White')
        expect(parking_space.vehicle_number).to eql('01')
        expect(parking_space.vehicle_color).to eql('White')
      end
    end
  end
end
