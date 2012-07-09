module ScheduleScraper
  class Config
    class << self
      attr_accessor :types
    end

    def self.register_type(klass)
      @types = {} unless @types

      key = klass.to_s.downcase.split("::")[1].to_sym

      @types[key] = klass
    end
  end
end
