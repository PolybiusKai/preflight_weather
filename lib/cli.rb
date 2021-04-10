#require_relative './env.rb'

class CLI 
    attr_accessor :data, :metar_data
    def initialize
        data = []
        metar_data = []
    end

    def call 
        input = ""
        menu
        while input != "exit"
            print ">> "
            input = gets.strip
            
            case input
            when "metar"
                print "Enter ICAO Location: "
                x = gets.strip.upcase 
                search_acio_location(x)
                puts "\n"
                get_metar_data
            when "list airports"
                list_airports
            when "help"
                menu
            end
        end
    end
    
      def search_acio_location(location)
        API.search_by_icao(location)
      end
    
      ## TODO - CURRENT
        # Breakdown raw metar data for easy read. 
      def get_metar_data
        @data = API.get_preflight_data
        @metar_data = PreFlight.new(data)
        raw = metar_data.raw
        puts "METARS Reading: #{raw}\n\n" 
        print "Would you like to see this broken down? y/N "
        response = gets.strip.downcase
        if response != "n"
            metar_breakdown
        end
      end

      def metar_breakdown
        puts "___Full METARS Breakdown___\n\n"

        #Metars Breakdown Data
        station = metar_data.station
        time =  metar_data.time["dt"]
        wind = "Wind Direction: #{metar_data.wind_direction["repr"]}\nWind Speed: #{metar_data.wind_speed["repr"]} #{metar_data.units["wind_speed"]}"
        visi = metar_data.visibility["repr"] + " " + metar_data.units["visibility"]
        sky_conditions = metar_data.clouds  
        temp_dew_point =  metar_data.temperature["repr"] + " " + metar_data.units["temperature"] + "/" + metar_data.dewpoint["value"].to_s
        alti = metar_data.altimeter["value"].to_s
        remarks = metar_data.remarks
        
        #Call Metars Breakdown
        puts "Station: #{station}"      
        puts "Time: #{time}" 
        puts wind
        puts "Visibility: #{visi}" 
        if sky_conditions == []
            puts "Sky Conditions: CLR"
        else  
            puts "Sky Conditions: #{sky_conditions}" 
        end  
        puts "Temp/Dew Point: #{temp_dew_point}"
        puts "Altimiter: #{alti}"
        puts "Remarks: #{remarks}"
        # binding.pry
      end
    
      def list_airports
        data = API.get_icao_by_location
        station_data = Stations.new(data)
      end

      ## TODO - Create one big Multiline output. 
      def menu
        #What location/airport?
        #METAR, TAF, Station Data?
        #List All Common Stations?
        puts <<-HEREDOC    


              [#]  To see METAR Weather Data   - 'metar'.
              [#]  For Help Menu               - 'help'.
              [#]  To Exit The App             - 'exit'.


                HEREDOC
          
      end
    
      ## TODO - Add Colorization
        # TO banner.
        # TO output. 
      def self.welcome_msg
        #Other Fonts: ANSI Shadow, Larry 3D 2, Modular,Red Phoenix, Sub-Zero
        welcome_banner = RubyFiglet::Figlet.new " PreFlight\n   Weather", 'Sub-Zero' 
       
        welcome_banner.show
        print "\n\nPlease enter your name to begin: "
        name = gets.strip
        puts "\nHello #{name}, Welcome to your PreFlight information and Weather Check!\n\n"
      end
end
