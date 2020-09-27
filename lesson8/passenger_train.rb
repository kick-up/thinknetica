# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'

class PassengerTrain < Train
  def initialize(number)
    @type = 'Passenger'
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
