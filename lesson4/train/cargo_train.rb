class CargoTrain <  Train 
  def initialize(number)
    @type = "Cargo"
    super
  end

  def attachable_carriage?(carriage)
    if carriage.type  ==  :cargo
  end
end
