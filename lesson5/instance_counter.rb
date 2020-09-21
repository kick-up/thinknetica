module InstanceCounter
  def self.included(base)
    base.extend ClassMethod
    base.include InstanceMethods
  end

  module ClassMethod
    def instances
      @instances ||= 0
    end

    def register_instance
      @instances ||=  0 
      @instances += 1
    end
  end


    module InstanceMethods
      def register_insance
        self.class.register_insance
      end
    end
end