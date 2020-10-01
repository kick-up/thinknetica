# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'carriage'

# This thread is to ignore Documentation offense
class CargoCarriage < Carriage
  def initialize(number, volume)
    @type = 'Cargo'
    super
  end

  def to_s
    volume_info = "Доступный объем: #{available_volume}", "Объем загрузки: #{reserved_volume}"
    [number, type, manufacturer, volume_info].join(' - ')
  end
end
