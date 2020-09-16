class CargoTrain <  Train 
  def initialize(number)
    @type = "Cargo"
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
