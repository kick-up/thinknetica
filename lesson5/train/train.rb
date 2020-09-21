
require_relative '../instance_counter'
require_relative '../maker'

class Train
  attr_accessor :carriages
  attr_reader :route, :speed, :type,  :number


  include Maker
  include InstanceCounter


  @@trains  = {}

  def self.trains
  @@trains
  end


  def self.find(number)
  @@trains[number]
  end

  def initialize(number)
    @number = number
    @carriages  = []
    @speed  = 0
    @current_station_index  = 0
    @route  = []
    @@trains[number]  = self
    register_instance
  end

  def increase_speed(n)
    @speed +=  n
  end

  def decrease_speed(n)
    @speed -= n
    @speed = 0 if @speed < 0
  end

  def attach_carriage(carriage)
    return unless @speed.zero?
    @carriages  <<  carriage
  end

  def detach_carriage(carriages)
    return unless @speed.zero?
    @carriages.delete_at(-1)
  end

  def accept_route(route)
    @route =  route
    @current_station_index  = 0
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
    @route.stations[@current_station_index  - 1]
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
    @current_station_index  -=  1
    current_station.train_in(self)
  end

  def to_s
    [number,type, maker].join(" - ")
  end
end












