require_relative '../instance_counter'
require_relative '../maker'
require_relative './carriage'

class PassengerCarriage < Carriage

  ONE_PLACE = "Нельзя занимать за раз больше 1 места"
  
  def initialize (number, volume)
    @type = "Passenger"
    super
  end

  def take_place(volume = 1)
    raise ONE_PLACE if volume != 1
    super
  end

  def to_s 
    info_volume = "Свободные места: #{free_volume}", "Занятые места: #{total_volume}"
    [number,  type, maker, info_volume].join(' - ')
  end

end