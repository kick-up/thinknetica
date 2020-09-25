require_relative './instance_counter'
require_relative '../valid'
require_relative './train/train'
require_relative './train/cargo_train'
require_relative './train/passenger_train'

class Station
  attr_reader :name, :trains

  NAME_FORMAT = /\w/
  INVALID_NAME = 'Неверный формат. Используйте любые 2 латинские буквы, цифры и символы'

  include InstanceCounter
  include Valid

  @@stations  = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @stations << self register_instance
    validate!
  end

  def train_in(train)
    @trains <<  train
  end

  def train_out(train)
     @trains.delete(train)
  end

  def train_types(type)
      @trains.select do |train|
        train.type == type
      end
  end

  def each_train
      trains.each do |train|
        yield train
      end
  end

  def to_s
    name
  end

  protected

  def validate!
    raise  INVALID_NAME if @name !~ NAME_FORMAT
  end

end
