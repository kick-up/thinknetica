require_relative '../instance_counter'
require_relative '../maker'

class PassengerCarriage < Carriage
  def initialize
    @type = "Passenger"
    super
  end

end