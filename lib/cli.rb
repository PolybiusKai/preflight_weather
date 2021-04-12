#require_relative './env.rb'

class CLI 
    attr_accessor :data, :metar_data, :sky_conditions


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
                menu
            when "list airports"
                list_airports
            when "help"
                menu
            end
        end
    end #/call
    
      def search_acio_location(location)
        API.search_by_icao(location)
      end
    
      def get_metar_data
        @data = API.get_preflight_data
        @metar_data = PreFlight.new(data)
        raw = metar_data.raw
        puts "METAR => #{raw}\n\n" 
        #binding.pry
        breakdown
      end #/get_metar_data

      def breakdown
        print "Would you like to see this broken down? y/N "
        response = gets.strip.downcase
        if response == "y" || response != 'n' 
            metar_breakdown
        else
            puts "Please try agian"
            breakdown 
        end
      end
      
      def metar_breakdown
        #Metars Breakdown Data
        station = metar_data.station
        time =  metar_data.time["dt"]
        wind_direction = metar_data.wind_direction["repr"]
        wind_speed = "#{metar_data.wind_speed["repr"]}#{metar_data.units["wind_speed"]}"
        visi = metar_data.visibility["repr"] + "" + metar_data.units["visibility"]
        wx = metar_data.wx_codes
        sky_conditions = metar_data.clouds  
        temp_dew_point =  metar_data.temperature["repr"] + "°" + metar_data.units["temperature"] + "/" + metar_data.dewpoint["value"].to_s
        alti = metar_data.altimeter["value"].to_s
        remarks = metar_data.remarks
        
        #Weather Conditions Check
        if wx == []
            wx = "N/A"
        else
            wx = metar_data.wx_codes.collect {|x| x["value"]}
        #    binding.pry
        end
         
        #Sky Conditions Check
        if  sky_conditions == []
            sky_conditions = "Clear"
        else  
            sky_conditions = metar_data.clouds.collect {|x| x["repr"]}
        end  
        # binding.pry

        #Call Breakdown Data
        puts <<-HEREDOC 

     ___Full METARS Breakdown_________________________
    |
    |
    |    Station: #{station}                
    |    Time: #{time}                      
    |    Wind Direction: #{wind_direction}                                
    |    Wind Speed: #{wind_speed}      
    |    Visibility: #{visi}
    |    Weather: #{wx}
    |    Sky Conditions:  #{sky_conditions}                                                              
    |    Temp/Dew Point: #{temp_dew_point}                                                 
    |    Altimiter: #{alti}                                                               
    |    Remarks: #{remarks}                                                               
    |
    |_________________________________________________
          HEREDOC
      end #/metar_breakdown
    
      def list_airports
        data = API.get_icao_by_location
        station_data = Stations.new(data)
      end

      def menu
        #What location/airport?
        #METAR, TAF, Station Data?
        #List All Common Stations?
        puts <<-HEREDOC    


              [#]  To see METAR Weather Data   - 'metar'.
              [#]  For Help Menu               - 'help'.
              [#]  To Exit The App             - 'exit'.


                HEREDOC
          
      end #/menu
    
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
