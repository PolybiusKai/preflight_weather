class PreFlight

    #attr_accessor :raw, :station, :time_stamp, :wind, :visibility, :sky_conditions, :temp_dew_point, :altimeter, :remarks, :flight_rules
    @@all = []
    
    def initialize(attributes)
        attributes.each { |key, value| 
          self.class.attr_accessor(key)
          self.send(("#{key}="), value)
        }
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end
end

