require_relative '../instance_counter'
require_relative '../maker'

class PassengerTrain  < Train
  def initialize(type)
    @type = "Passenger"
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end

end
