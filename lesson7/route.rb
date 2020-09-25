require_relative '../instance_counter'
require_relative '../valid'

class Route
  attr_reader :origin, :transit_stations, :destination, :stations

  include Valid
  include InstanceCounter

  OBJECT_NIL = 'Маршрут должен иметь начальную или конечную станцию'
  DOUBLE_APPEARANCE = 'Станция не может быть конечной и начальной одновременно'



  def initialize(origin,destination)
    @origin = origin
    @destination  = destination
    @transit_stations = []
    validate!
  end

  def add_transit_station(station)
    @transit_stations <<  station
  end

  def delete_transit_station(station)
    @transit_stations.delete(station)
  end

  def stations
    [@origin, @transit_stations,  @destination]
  end

  def to_s
    [stations.first, @transit_stations, stations.last].join(' - ')
  end

  protected
  
  def validate!
      raise  OBJECT_NILif origin.nil? || destination.nil?
      raise  DOUBLE_APPEARANCE ifif origin == destination
      true
    end


end
