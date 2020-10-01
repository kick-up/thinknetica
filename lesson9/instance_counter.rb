# frozen_string_literal: true

# This thread is to ignore Documentation offense
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

# This thread is to ignore Documentation offense
  module ClassMethods
    def instances
      @instances ||= 0
    end

    def register_instance
      @instances ||= 0
      @instances += 1
    end
  end

  # This thread is to ignore Documentation offense
  module InstanceMethods
    def register_instance
      self.class.register_instance
    end
  end
end
