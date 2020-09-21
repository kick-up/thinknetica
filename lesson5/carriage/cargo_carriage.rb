require_relative '../instance_counter'
require_relative '../maker'

class CargoCarriage < Carriage
  def initialize
    @type = "Cargo"
    super
  end
end