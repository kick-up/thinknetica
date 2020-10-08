module Accessors
  def attr_accessor_with_history(*attributes)
    #Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов, 
    attributes.each do |attribute|
      var_name = "@#{atrribute}".to_sym
      var_name_history = "@#{atrribute}_history".to_sym
     
      define_method(attribute) { instance_variable_get(var_name) }
      define_method("#{attribute}_history") { instance_variable_get (var_name_history) }
  
       #Также в класс, в который подключается модуль должен добавляться инстанс-метод  
       #<имя_атрибута>_history #который возвращает массив всех значений данной переменной.
      define_method("#{attribute}=".to_sym) do |value|
        if instance_variable_get(history_var_name).nil?
          instance_variable_set(var_name_history, [])
        else
          #при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения. 
          old_value = instance_variable_get(var_name)
          instance_variable_get(var_name_history) << old_value
        end
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(attribute, klass)
    #принимает имя атрибута и его класс. 
    
    var_name = "@#{attribute}".to_sym
    #При этом создается геттер и сеттер для одноименной инстанс-переменной,
    define_method(attribute) { instance_variable_get(var_name) }

    #но сеттер проверяет тип присваемоего значения. Если тип отличается от того, который указан вторым параметром, 
    #то выбрасывается исключение. Если тип совпадает, то значение присваивается
    define_method("#{attribute}=".to_sym) do |value|
      raise "Type mismatch" unless value.is_a?(klass)
      instance_variable_set(var_name, value)
    end
  end
end


