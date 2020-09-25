require_relative("route")
require_relative("station")
require "./carriage/carriage"
require "./carriage/cargo_carriage"
require "./carriage/passenger_carriage"
require "./train/train"
require "./train/cargo_train"
require "./train/passenger_train"

class Main

  include Maker

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  include Maker

  TRAIN_TYPES = [PassengerTrain, CargoTrain]

  def print_state
    system("clear")
    puts "---------------------"
    show_assets
    puts "---------------------"
  end

  def menu
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
    puts "11. Указать компанию производителя поезда"
    puts "12. Указать компанию производителя вагона"
    puts '13. Список вагонов у поезда'
    puts '14. Управление вагонами (погрузка, посадка)'
    puts "0. Выйти из программы"
    print_state
  end

  def create_station
    puts "Введите название станции:"
    begin
    new_station = gets.chomp
    @stations << Station.new(new_station)
    rescue => e
    puts e.message
    retry
    end
    puts "Вы добавили станцию #{new_station}"

  end

  def create_train
    puts "Выберите тип поезда. Укажите 1 для пассажирского и 2 для грузового:"
    p train_type = select_from_collection(TRAIN_TYPES)
    return if train_type.nil?
    puts "Укажите номер поезда:"
    begin
    train_number = gets.chomp
    @trains << train_type.new(train_number)
    rescue => e
    puts e.message
    retry
    end
  end

  def create_route
    puts "Укажите начальную станцию, выбрав индекс из списка"
    show_collection(@stations)
    origin_station = select_from_collection(@stations)
    begin
    puts "Укажите конечную станцию, выбрав из списка"
    show_collection(@stations)
    destination_station = select_from_collection(@stations)
    rescue => e
    puts e.message
    retry
    end
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
      puts 'Список вагонов'
      show_collection(@carriages)

      @stations.each do |station|
      puts "Поезда на станции #{station}:"
      station.each_train { |train| puts train }
    end

      @trains.each do |train|
      puts "Вагоны прикрепленные к поезду #{train.number}:"
      train.each_carriage { |carriage| puts carriage }
    end
  end

  def carriage_list_per_train
      puts 'Выберите поезд:'
      show_collection(@trains)
      train = select_from_collection(@trains)
      show_collection(train.carriages)
    end

  def volume_manager
      puts 'Выберите поезд:'
      show_collection(@trains)
      train = select_from_collection(@trains)
      puts 'Выберите вагон:'
      show_collection(train.carriages)
      carriage = select_from_collection(train.carriages)
      begin
        case train.type
        when 'Cargo'
          puts 'Укажите объем погрузки:'
          volume = gets.to_i
          carriage.take_place(volume)
        when 'Passenger'
          puts 'Было занято одно место.'
          carriage.take_place
          carriage.volume
        end
      rescue => e
        puts e.message
      end
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

  def assign_maker(item,object)
    puts "Чтобы указать компанию производителя выберите соответсвующий индекс #{item}"
    show_collection(object)
    object =  select_from_collection(object)
    puts "Укажите компания производителя"
    object.maker = gets.chomp.to_s
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

      when 11 then
        assign_maker("поезд", @trains)

      when 12 then 
        assign_maker("вагон", @carriages)

      when 13 then carriage_list_per_train
              
      when 14 then volume_manager

      when 0 then break
      end
    end
  end
end

new_session = Main.new
new_session.run