class PassengerTrain  < Train
  def initialize(number)
    @type = "Passenger"
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
