# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'

# This thread is to ignore Documentation offense
class Train
  attr_accessor :carriages
  attr_reader :route, :speed, :type, :number

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze
  INVALID_NUMBER = 'Неверный формат. Допустимый формат: три буквы '\
    'латинские буквы или цифры в любом порядке необязательный дефис '\
    '(может быть, а может нет) и еще 2 буквы латинские буквы или цифры '\
    'после дефиса.'

  include Manufacturer
  include InstanceCounter
  include Validation

  validate :number, :format, NUMBER_FORMAT

  @@trains = {}

  def self.trains
    @@trains
  end

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @current_station_index = 0
    @route = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed
    @speed = 0 if @speed.negative?
  end

  def attach_carriage(carriage)
    return unless @speed.zero?
    return unless attachable_carriage?(carriage)

    @carriages << carriage
  end

  def detach_carriage(_carriage)
    return unless @speed.zero?

    @carriages.delete_at(-1)
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
    current_station.train_in(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    return unless @current_station_index.positive?

    @route.stations[@current_station_index - 1]
  end

  def move_forward
    return if next_station.nil?

    current_station.train_out(self)
    @current_station_index += 1
    current_station.train_in(self)
  end

  def move_backward
    return if previous_station.nil?

    current_station.train_out(self)
    @current_station_index -= 1
    current_station.train_in(self)
  end

  def each_carriage
    carriages.each do |carriage|
      yield carriage
    end
  end

  def to_s
    train_count = "Количество вагонов: #{carriages.count}"
    [number, type, manufacturer, train_count].join(' - ')
  end

  #protected

  # def validate!
    # raise INVALID_NUMBER if number !~ NUMBER_FORMAT
  # end
end
