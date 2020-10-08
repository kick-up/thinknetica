module Validation
  module ClassMethods
    attr_reader :validations
    #Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута, 
    #а также тип валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
    #presence - требует, чтобы значение атрибута было не nil и не пустой строкой
    #пример validate :name, :presence

    def validate(name, type, *params)
      @validations ||= []
      @validations << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    def validate_presence(value)
      raise "Value is nil" if value.nil? || value.strip.empty?
    end

    #format (при этом отдельным параметром задается регулярное выражение для формата). 
    #Треубет соответствия значения атрибута заданному регулярному выражению. Пример:  
    #validate :number, :format, /A-Z{0,3}/

    def validate_format(value, format)
      raise "Wrong format" if value !~ format
    end

    #type (третий параметр - класс атрибута). 
    #Требует соответствия значения атрибута заданному классу. Пример
    #validate :station, :type, RailwayStation

    def validate_type(value, type)
      raise "Invalid type" unless value.is_a?(type)
    end

    #Содержит инстанс-метод validate!, который запускает все проверки (валидации), 
    #указанные в классе через метод класса validate. 
    #В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла

    def validate!
      self.class.validations.each do |validation|
        val = instance_variable_get("@#{validation[:name]}")
        send "validate_#{validation[:type]}", val, *validation[:params]
      end
    end

    #Содержит инстанс-метод valid? который возвращает true, 
    #если все проверки валидации прошли успешно и false, если есть ошибки валидации

    def valid?
      validate!
      true
    rescue StandardError => e
      false
    end
    # Содержит инстанс-метод valid? который возвращает true,
    # если все проверки валидации прошли успешно и false, если есть ошибки валидации.
  end
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

#К любому атрибуту можно применить несколько разных валидаторов, например
#validate :name, :presence
#validate :name, :format, /A-Z/
#validate :name, :type, String
 #Все указанные валидаторы должны применяться к атрибуту