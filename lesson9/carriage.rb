# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'valid'

# This thread is to ignore Documentation offense
class Carriage
  attr_accessor :volume
  attr_reader :type, :number, :reserved_volume

  NUMBER_FORMAT = /^[\w]{2,}$/.freeze
  INVALID_NUMBER = 'Неверный формат. Используйте любые 2 латинские '\
    'буквы, цифры и символы - и _'
  NOT_ENOUGH_VOLUME = 'Поезд перегружен'

  include Manufacturer
  include InstanceCounter
  include Valid

  def initialize(number, volume)
    @type = type
    @number = number
    @volume = volume
    @reserved_volume = 0
    validate!
    register_instance
  end

  def to_s
    [number, type, manufacturer].join(' - ')
  end

  def take_space(volume)
    raise NOT_ENOUGH_VOLUME if volume > available_volume

    @reserved_volume += volume
  end

  def available_volume
    @volume - @reserved_volume
  end

  protected

  def validate!
    raise INVALID_NUMBER if @number !~ NUMBER_FORMAT
  end
end
