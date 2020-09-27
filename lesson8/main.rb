require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'

class Main
  include Manufacturer

  TRAIN_TYPES = [PassengerTrain, CargoTrain].freeze

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def print_state
    # system("clear")
    puts '---------------------'
    show_assets
    puts '---------------------'
  end

  def menu
    puts '---------------------'
    puts 'Панель управления железно-дорожной станцией. Выберите действие указав номер:'
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создание маршрута'
    puts '4. Добавить станцию в маршрутный лист'
    puts '5. Удалить станцию из маршрутного листа'
    puts '6. Назначение маршрута поезду'
    puts '7. Прицепить вагон'
    puts '8. Отцепить вагон'
    puts '9. Управление движением поезда'
    puts '10. Указать компанию-производителя поезда'
    puts '11. Указать компанию-производителя вагона'
    puts '12. Список вагонов у поезда'
    puts '13. Управление вагонами (погрузка, посадка)'
    puts '0. Выйти из программы'
    print_state
  end

  def create_station
    puts 'Введите название станции:'
    begin
      new_station = gets.chomp
      @stations << Station.new(new_station)
      puts "Вы добавили станцию #{new_station}"
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def create_train
    puts 'Выберите тип поезда. Укажите 1 для пассажирского и 2 для грузового:'
    p train_type = select_from_collection(TRAIN_TYPES)
    return if train_type.nil?

    puts 'Укажите номер поезда:'
    begin
      train_number = gets.chomp
      @trains << train_type.new(train_number)
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def create_route
    puts 'Укажите начальную станцию, выбрав индекс из списка'
    show_collection(@stations)
    origin_station = select_from_collection(@stations)

    puts 'Укажите конечную станцию, выбрав из списка'
    show_collection(@stations)
    destination_station = select_from_collection(@stations)
    @routes << Route.new(origin_station, destination_station)
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_route_station
    puts 'Выберите маршрут из списка, указав индекс'
    show_collection(@routes)
    route = select_from_collection(@routes)
    puts 'Выберите следующую транзитную станцию:'
    show_collection(@stations)
    transit_station = select_from_collection(@stations)
    route.add_transit_station(transit_station)
  end

  def delete_route_station
    puts 'Выберите маршрут из списка, указав индекс'
    show_collection(@routes)
    route = select_from_collection(@routes)
    puts 'Выберите транзитную станцию для удаления:'
    show_collection(route.stations)
    transit_station = select_from_collection(route.stations)
    route.delete_transit_station(transit_station)
  end

  def assign_route
    puts 'Выберите поезд из списка, указав индекс'
    show_collection(@trains)
    train = select_from_collection(@trains)

    puts 'Выберите маршрут из списка, указав индекс'
    show_collection(@routes)
    route = select_from_collection(@routes)

    train.accept_route(route)
  end

  def attach_carriage_controller
    puts 'Чтобы прицепить вагон к поезду, укажите индекс поезда'
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts 'Выберите тип вагона: 1 - Passenger или 2 - Cargo'
    carriage = gets.to_i
    puts 'Укажите номер вагона'
    number = gets.chomp.to_s
    case carriage
    when 1
      puts 'Укажите количество посадочных мест в вагоне:'
      seats = gets.to_i
      carriage = PassengerCarriage.new(number, seats)
      train.attach_carriage(carriage)
      @carriages << carriage
    when 2
      puts 'Укажите объем вагона(квадратных метров):'
      volume = gets.to_i
      carriage = CargoCarriage.new(number, volume)
      train.attach_carriage(carriage)
      @carriages << carriage
    end
  end

  def detach_carriage_controller
    puts 'Чтобы отцепить вагон от поезда, укажите индекс поезда'
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts 'Выберите вагон, который хотите отцепить'
    show_collection(train.carriages)
    carriage = gets.to_i
    train.detach_carriage(train.carriages[carriage])
  end

  def train_controller
    puts 'Чтобы управлять поездом, укажите индекс поезда'
    show_collection(@trains)
    train = select_from_collection(@trains)
    puts 'Выберите направление движения: 1 - вперед, 2 - назад'
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

  def assign_manufacturer(item, object)
    puts "Чтобы указать компанию-производителя, укажите индекс #{item}"
    show_collection(object)
    object = select_from_collection(object)
    puts 'Укажите название компании-производителя'
    object.manufacturer = gets.chomp.to_s
    p object
  end

  def show_assets
    puts 'Список станций:'
    show_collection(@stations)
    puts 'Список поездов:'
    show_collection(@trains)
    puts 'Список маршрутов'
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
        carriage.take_space(volume)
      when 'Passenger'
        puts 'Было занято одно место.'
        carriage.take_space
        carriage.volume
      end
    rescue StandardError => e
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

  def run
    loop do
      menu
      choice = gets.to_i
      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_route_station
      when 5 then delete_route_station 
      when 6 then assign_route
      when 7 then attach_carriage_controller
      when 8 then detach_carriage_controller
      when 9 then train_controller
      #when 10 then show_assets
      when 10 then assign_manufacturer('поезда', @trains)
      when 11 then assign_manufacturer('вагона', @carriages)
      when 12 then carriage_list_per_train
      when 13 then volume_manager
      when 0 then break
      end
    end
  end
end

new_session = Main.new
new_session.run