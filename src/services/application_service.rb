require_relative '../helpers/pretty_print_json'

class ApplicationService
  def initialize params, opts={}
    @params = params
    @opts  = opts
  end

  def process
    raise 'Not Implemented!'
  end

  def set_result
    true
  end

  private
  attr_accessor :params, :opts
end
