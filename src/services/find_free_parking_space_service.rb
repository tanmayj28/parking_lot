require_relative 'application_service'

class FindFreeParkingSpaceService < ApplicationService 
  def process
    find_free_parking &&
      set_result
  end

  private
  attr_reader :free_parking

  def find_free_parking
    @free_parking = params[:parking_spaces].find do |parking_space|
      parking_space.free?
    end
  end

  def set_result
    free_parking
  end
end
