require_relative '../instance_counter'
require_relative '../maker'
require_relative './carriage'

class CargoCarriage < Carriage
  
  def initialize(number, volume)
    @type = "Cargo"
    super
  end

  def to_s
      info_volume =  "Доступный объем: #{free_volume}", "Объем загрузки: #{total_volume}"
      [number, type, maker, info_volume].join(' - ')
  end

end