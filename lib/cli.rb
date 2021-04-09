#require_relative './env.rb'

class CLI 

    # def initialize
    # end

    def call 
        input = ""
        menu
        while input != "exit"
            input = gets.strip
            
            case input
            when "metar"
                puts "Enter ICAO Location: "
                x = gets.strip.upcase 
                add_location(x)
                puts "\n"
                get_metar_data
            when "list airports"
                list_airports
            when "menu"
                menu
            end
        end
    end
    
      def add_location(location)
        API.find_by_location(location)
      end
    
      def get_metar_data
        data = API.get_preflight_data
        metar_data = PreFlight.new(data)
        puts "Metar: #{metar_data.raw}\n\n"       
        menu
      end
    
      def list_airports

      end

      def menu
            #What location/airport?
            #METAR, TAF, Station Data?
            #List All Common Stations?
            puts "To see METAR Data 'metar'."
            puts "For help 'menu'."
            puts "To exit 'exit'."
      end
    
      def self.welcome_msg
        #Other Fonts: ANSI Shadow, Larry 3D 2, Modular,Red Phoenix, Sub-Zero
        welcome_banner = RubyFiglet::Figlet.new " PreFlight\n   Weather", 'Sub-Zero' 
       
        welcome_banner.show
        print "\n\nPlease enter your name to begin: "
        name = gets.strip
        puts "\nHello #{name}, Welcome to your PreFlight Weather Check!\n\n"
      end
end
