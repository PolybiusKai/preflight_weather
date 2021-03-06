
class Stations
    attr_accessor :city, :icao
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

