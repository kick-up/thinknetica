# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'carriage'

# This thread is to ignore Documentation offense
class PassengerCarriage < Carriage
  ONE_PER_REQUEST = 'Нельзя занимать больше 1 места за раз'

  def initialize(number, volume)
    @type = 'Passenger'
    super
  end

  def take_space(volume = 1)
    raise ONE_PER_REQUEST if volume != 1

    super
  end

  def to_s
    volume_info = "Свободные места: #{available_volume}", "Занятые места: #{reserved_volume}"
    [number, type, manufacturer, volume_info].join(' - ')
  end
end
