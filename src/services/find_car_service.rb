require_relative 'application_service'

class FindCarService < ApplicationService 
  def process
    find_car &&
      set_result
  end

  private
  attr_reader :searchable

  def find_car
    @searchable = []
    params[:parking_spaces].each do |parking_space|
      searchable << parking_space.public_send(params[:searchable]) if parking_space.public_send("vehicle_#{params[:search_by]}") == params[:search_for]
    end
    !searchable.empty?
  end

  def set_result
    headers = [params[:searchable].split('_').collect(&:capitalize).join(' ')]
    PrettyOutput.print(headers, searchable)
  end
end
