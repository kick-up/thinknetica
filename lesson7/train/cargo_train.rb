require_relative '../instance_counter'
require_relative '../maker'


class CargoTrain <  Train 
  

  def initialize(number)
    @type = "Cargo"
    super
  end

  def attachable_carriages?(carriage)
    carriage.is_a?(CargoCarriage)
  end
  
  
end
