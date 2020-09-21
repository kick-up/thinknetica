require_relative '../instance_counter'
require_relative '../maker'


class Carriage
  attr_reader :type,:number

  include Maker
  include InstanceCounter

  def initialize(number)
    @type = type
    @number = number
    register_instance
  end

  def to_s
    [number,type,maker].join(" - ")
  end

end