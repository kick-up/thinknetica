#Класс Route (Маршрут):
#Имеет начальную и конечную станцию, а также список промежуточных станций. 
#Начальная и конечная станции указываютсся при создании маршрута, 

class Route
  attr_reader :start, :transit, :end
  def initialize(start, end)
    @start  = start
    @end  = end
    @transit  = []
  end

# промежуточные могут добавляться между ними.
#Может добавлять промежуточную станцию в список
  def add_transit(station)
    @transit << station
  end

#Может удалять промежуточную станцию из списка
  def delete_transit(station)
    @transit.delete(station)
  end

#Может выводить список всех станций по-порядку от начальной до конечной
  def station
    [@start, @transit, @end]
  end
end
