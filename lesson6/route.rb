require_relative '../instance_counter'
require_relative '../valid'

class Route
  attr_reader :origin, :transit_stations, :destination, :stations

  include Valid


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
    [stations.first, [@transit_stations], stations.last].join(' - ')
  end

  protected
  
  def validate!
      raise "Маршрут должен иметь начальную или конечную станцию" if origin.nil? || destination.nil?
      raise "Станция не может быть конечной и начальной одновременно" if origin == destination
      true
    end


end
