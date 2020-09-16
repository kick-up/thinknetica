class Train
  attr_writer :carriages
  attr_reader :carriages, :route, :speed, :type,  :number
  
  def initialize(number)
    @number = number
    @carriages  = []
    @speed  = 0
    @current_station_index  = 0
    @route  = []
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
    return unless attachable_carriage?(carriages)
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
    current_stations.train_out(self)
    @current_station_index += 1
    current_stations.train_in(self)
  end

  def move_backward
    return if previous_station.nil?
    current_stations.train_out(self)
    @current_station_index  -=  1
    current_stations.train_in(self)
  end

  def to_s
    [number,type].join(" - ")
  end
end












