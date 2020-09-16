class Station
  attr_reader :name, :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def train_in(train)
    @trains <<  train
  end

  def train_out(train)
    @trains.select do |train|
      train.type  ==  type
    end
  end

    def to_s
      name
    end
  end
