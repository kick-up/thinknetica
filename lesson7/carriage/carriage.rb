require_relative '../instance_counter'
require_relative '../maker'
require_relative '../valid'


class Carriage
  attr_reader :type, :number, :reserved_volume
  attr_accessor :volume

  NUMBER_FORMAT = /\w/
  NVALID_NUMBER = "Неверный формат. Используйте любые латинские буквы, цифры и символы"
  VOLUME_IS_INSUFFICIENT = "Поезд перегружен"



  include Maker
  include InstanceCounter
  include Valid

  def initialize(number, volume)
    @type = type
    @number = number
    register_instance
    validate!
    @total_volume  =  0
    @volume   = volume
  end

  def to_s
    [number,type,maker].join(" - ") 
  end

  def take_place(volume)
      raise  VOLUME_IS_INSUFFICIENT if volume > free_volume 
 
      @total_volume += volume
  end

  def free_volume 
      @volume - @total_volume
  end

protected

def validate!
    raise INVALID_NUMBER_CARRIAGE if @number.length < 1
    raise NVALID_NUMBER  if @number !~ NUMBER_FORMAT
    true
  end



end