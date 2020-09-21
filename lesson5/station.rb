require_relative './instance_counter'

class Station
  attr_reader :name, :trains

  include InstanceCounter

  @@stations  = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @stations << self register_instance
  end

  def train_in(train)
    @trains <<  train
  end

  def train_out(train)
     @trains.delete(train)
  end

    def to_s
      name
    end
  end
