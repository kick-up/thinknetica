require_relative("route")
require_relative("station")
require "./carriage/carriage"
require "./carriage/cargo_carriage"
require "./carriage/passenger_carriage"
require "./train/train"
require "./train/cargo_train"
require "./train/passenger_train"

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

private

  TRAIN_TYPES = [PassengerTrain, CargoTrain]

  def print_state
    system("clear")
    puts "---------------------"
    show_assets
    puts "---------------------"
  end

  def menu
    print_state
    puts "Панель управления железно-дорожной станцией. Выберите действие указав соответсвующий номер:"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создание маршрута маршрутами"
    puts "4. Назначение маршрута поезду"
    puts "5. Прицепить вагон"
    puts "6. Отцепить вагон"
    puts "7. Управление поездом"
    puts "8. Список станций и поездов на станции"
    puts "9. Добавить станцию в маршрутный лист"
    puts "10. Удалить станцию из маршрутного листа"
    puts "0. Выйти из программы"
  end

  def create_station
    puts "Введите название станции:"
    new_station = gets.chomp
    @stations << Station.new(new_station)
    puts "Вы добавили станцию #{new_station}"
  end

  def create_train
    puts "Выберите тип поезда. Укажите 1 для пассажирского и 2 для грузового:"
    p train_type = select_from_collection(TRAIN_TYPES)
    return if train_type.nil?
    puts "Укажите номер поезда:"
    train_number = gets.chomp
    @trains << train_type.new(train_number)
  end

  def create_route
    puts "Укажите начальную станцию, выбрав индекс из списка"
    show_collection(@stations)
    origin_station = select_from_collection(@stations)
    
    puts "Укажите конечную станцию, выбрав из списка"
    show_collection(@stations)
    destination_station = select_from_collection(@stations)
   
    return if origin_station.nil? || destination_station.nil?
    return if origin_station == destination_station
    
    @routes << Route.new(origin_station, destination_station)
  end


  def add_route_station
    puts "Выберите маршрут из списка, указав индекс"
    show_collection(@routes)
    route = select_from_collection(@routes)
    puts "Выберите следующую транзитную станцию:"
    show_collection(@stations)
    transit_station = select_from_collection(@stations)
    route.add_transit_station(transit_station)
  end

  def delete_route_station
    puts "Выберите маршрут из списка, указав индекс"
    show_collection(@routes)
    route = select_from_collection(@routes)
    puts "Выберите транзитную станцию для удаления:"
    show_collection(route.stations)
    transit_station = select_from_collection(route.stations)
    route.delete_transit_station(transit_station)
  end

  def assign_route
    puts "Выберите поезд из списка, указав индекс"
    show_collection(@trains)
    train = select_from_collection(@trains)

    puts "Выберите маршрут из списка, указав индекс"
    show_collection(@routes)
    route = select_from_collection(@routes)

    train.accept_route(route)
  end

  def attach_carriage_controller
    puts "Чтобы прицепить вагон к поезду, укажите индекс поезда"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите тип вагона: 1 - Passenger или 2 - Cargo"
    carriage = gets.to_i
    case carriage
    when 1
      train.attach_carriage(PassengerCarriage.new)
    when 2
      train.attach_carriage(CargoCarriage.new)
    end
  end

  def detach_carriage_controller
    puts "Чтобы отцепить вагон от поезда, укажите индекс поезда"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите вагон, который хотите отцепить"
    show_collection(train.carriages)
    carriage = gets.to_i
    train.detach_carriage(train.carriages[carriage])
  end

  def train_controller
    puts "Чтобы управлять поездом, укажите индекс поезда"
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts "Выберите направление движения: 1 - вперед, 2 - назад"
    direction = gets.to_i
    case direction
    when 1
      train.move_forward
      puts "Текущая станция: #{train.current_station}"
    when 2
      train.move_backward
      puts "Текущая станция: #{train.current_station}"
    end
    
  end

  def show_assets
    puts "Список станций:"
    show_collection(@stations)
    puts "Список поездов:"
    show_collection(@trains)
    puts "Список маршрутов"
    show_collection(@routes)
  end

  def show_collection(collection)
    collection.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
    end
  end

  def select_from_collection(collection)
    index = gets.to_i - 1
    return if index.negative?
    collection[index]
  end


  def run
    loop do
      menu
      choice = gets.to_i
      case choice
      when 1 then create_station

      when 2 then create_train

      when 3 then create_route

      when 4 then assign_route

      when 5 then attach_carriage_controller

      when 6 then detach_carriage_controller

      when 7 then train_controller

      when 8 then show_assets

      when 9 then add_route_station

      when 10 then delete_route_station

      when 0 then break
      end
    end
  end
end

new_session = Main.new
new_session.run
