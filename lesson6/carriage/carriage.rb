require_relative '../instance_counter'
require_relative '../maker'
require_relative '../valid'


class Carriage
  attr_reader :type,:number

  NUMBER_FORMAT = /\w/

  include Maker
  include InstanceCounter
  include Valid

  def initialize(number)
    @type = type
    @number = number
    register_instance
    validate!
  end

  def to_s
    [number,type,maker].join(" - ")
  end

protected

def validate!
    raise "Номер вагона не может быть пустым " if @number.nil?
    raise "Номер вагона должен содержать хотя бы один символ" if @number.length < 1
    raise "Неверный формат. Используйте любые латинские буквы, цифры и символы" if @number !~ NUMBER_FORMAT
    true
  end



end