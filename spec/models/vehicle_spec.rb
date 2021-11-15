require_relative '../../src/models/vehicle'

RSpec.describe Vehicle do
  describe 'initialize' do
    context 'valid input params' do
      it 'should return vehicle instance' do
        vehicle = Vehicle.new('01', 'black')
        expect(vehicle.class).to eql(Vehicle)
        expect(vehicle.number).to eql('01')
        expect(vehicle.color).to eql('black')
      end
    end

    context 'invalid input params' do
      it 'should throw exception' do
        expect { Vehicle.new }.to raise_error(ArgumentError)
        expect { Vehicle.new('number') }.to raise_error(ArgumentError)
      end
    end
  end
end
