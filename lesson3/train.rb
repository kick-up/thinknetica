#Класс Train (Поезд):


class Train
  attr_reader :number, :carriages, :type, :speed :route
#Имеет номер (произвольная строка) и тип (грузовой, пассажирский) 
#и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages  = carriages
    @speed  = 0
    @current_station  = 0
    @route  = []
  end
 
 #Может набирать скорость
  def increase_speed(x)
    @speed += x
  end

  #Может возвращать текущую скорость
  #Может тормозить (сбрасывать скорость до нуля)
  def decrease_speed(x)
    @speed -= x
    @speed  = 0 if @speed < 0
  end

#Может прицеплять/отцеплять вагоны 
#Может возвращать количество вагонов
#(по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов)
##Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def attach_carriage
    return @speed if @speed == 0
    @carriages  +=  1
  end

  def detcah_carriage
    return @speed if @speed  == 0
    return  @carriages -= 1
  end
#Может принимать маршрут следования (объект класса Route). 
#При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
#Может перемещаться между станциями, указанными в маршруте. П
#Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

  def take_rout(route)
    @route  ==  route
    @current_station  ==  0
  end

  def current_station
    @route[@current_station]
  end

  def next_station
    @route[current_station  + 1]
  end

  def previous_station
    @route[@current_station  -  1]
  end

#Перемещение возможно вперед и назад, 
#но только на 1 станцию за раз.

  def move
    if next_station.nil?
      @current_station += 1
  end

  def back
    if previous_station.nil?
      @current_station -= 1
  end

end



