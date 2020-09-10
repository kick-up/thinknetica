#Класс Station (Станция):
#Имеет название, которое указывается при ее создании
#Может принимать поезда (по одному за раз)
#Может возвращать список всех поездов на станции, находящиеся в текущий момент
#Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, 
#пассажирских
#Может отправлять поезда (по одному за раз, 
#при этом, поезд удаляется из списка поездов, находящихся на станции).

require_relative("train")
require_relative("route")


class Station
  attr_reader :name :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def train_in(train)
    @trains <<  train
  end

  def train_out(train)
    @train.delete(train)
  end

  def train_types(type)
    @train.select do |train|
      train.train_types ==  type
  end
end
