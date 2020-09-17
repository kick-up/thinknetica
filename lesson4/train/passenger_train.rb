class PassengerTrain  < Train
  def initialize(number)
    @type = "Passenger"
    super
  end

  def attachable_carriage?(carriage)
    if carriage.type == :passanger
  end
end
