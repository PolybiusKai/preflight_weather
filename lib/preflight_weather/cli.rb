
class CLI 
    attr_accessor :data, :metar_data, :station_data, :station_state

    def call 
        input = ""
        menu
        while input != "exit"
            print ">> ".green
            input = gets.strip
            
            case input
            when "metar"
                locate
                get_metar_data
                breakdown
                airport_info
                menu
            when "station"
                locate
                list_station_data
            when "list"
                puts "\n"
                icao_list
            when "help"
                menu
            end
        end
    end #/call
    
    def search_acio_location(location)
        API.search_by_icao(location)
    end

    def locate 
        print "Enter ICAO Location: "
        x = gets.strip.upcase 
        if x == "EXIT"
            exit 
        end
        x.length != 4 ? locate : x[0] != "K" ? locate : search_acio_location(x)
    end
    
    def get_metar_data
        @data = API.get_preflight_data
        @metar_data = PreFlight.new(data)
        raw = metar_data.raw.light_blue
        puts "METARs => #{raw}\n\n"
    end #/get_metar_data

    def breakdown
        print "Would you like to see this broken down? y/N "
        response = gets.strip.downcase
        if response == "y" 
            metar_breakdown
        elsif response == "n"
            
        elsif response == "exit"
            exit
        else
            puts "Please try agian"
            breakdown 
        end
    end

    def airport_info
        print "\n\nWould you like to see the Airport Info? y/N "
        response= gets.strip.downcase
        if response == "y" 
            list_station_data
        elsif response == "n"
            puts "What would you like to do next?"
        elsif response == "exit"
            exit
        else
            puts "Please try agian"
            airport_info 
        end
    end
      
    def metar_breakdown
        #METARs Breakdown Data
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
        wx == [] ? wx = "Clear".light_blue : wx = metar_data.wx_codes.collect {|x| x["value"]}
         
        #Sky Conditions Check
        sky_conditions == [] ? sky_conditions = "Clear".light_blue : sky_conditions = metar_data.clouds.collect {|x| x["repr"]}.join(" ").light_blue

        #Call Breakdown Data
        puts <<-HEREDOC

     ___Full METARs Breakdown_________________________
    |
    |
    |    Station: #{station.light_blue} - #{list_airport_name.light_blue}            
    |    Time: #{time.light_blue}                      
    |    Wind Direction: #{wind_direction.light_blue}                                
    |    Wind Speed: #{wind_speed.light_blue}      
    |    Visibility: #{visi.light_blue}
    |    Weather: #{wx}
    |    Sky Conditions:  #{sky_conditions}                                                         
    |    Temp/Dew Point: #{temp_dew_point.light_blue}                                                 
    |    Altimiter: #{alti.light_blue}                                                               
    |    Remarks: #{remarks.light_blue}                                                               
    |
    |_________________________________________________
          HEREDOC
    end #/metar_breakdown
    
    def list_airport_name
        data = API.get_station_by_icao
        @station_data = Stations.new(data)
        state = station_data.state
        station_data.name + ", " + state
    end

    def list_station_data
        data = API.get_station_by_icao
        @station_data = Stations.new(data)
        station_name = station_data.name
        station_icao = station_data.icao
        station_city = station_data.city
        @station_state = station_data.state
        station_latitude = station_data.latitude.to_s
        station_longitude = station_data.longitude.to_s
        station_type = station_data.type 
        station_website = station_data.website
        station_website == nil ? station_website = "N/A".light_blue  : station_website = station_data.website.light_blue 
        puts <<-HEREDOC

        ___Full Station Breakdown_________________________
       |
       |
       |    Station:     #{station_icao.light_blue} - #{station_name.light_blue}              
       |    City:        #{station_city.light_blue} 
       |    State:       #{station_state.light_blue}                    
       |    Latitude:    #{station_latitude.light_blue}                         
       |    Longitude:   #{station_longitude.light_blue}       
       |    Website:     #{station_website}
       |    Runway Type: #{station_type.light_blue}                                                             
       |                                                    
       |_________________________________________________

             HEREDOC
    end

    def icao_list
        table = CSV.parse(File.read("airport_data.csv"), headers: true)
        table.each_with_index {|icao, i| puts "#{i + 1}. #{icao[0].light_blue} - #{icao[1]}"}
        puts "\n"
    end

    def menu
        #TAF?
        #List top 50 Stations?
        puts <<-HEREDOC.green    


              [#]  To see METARs Weather Data   - 'metar'.
              [#]  To see Station Data          - 'station'.
              [#]  To see a List of Airports    - 'list'.
              [#]  For Help Menu                - 'help'.
              [#]  To Exit The App              - 'exit'.


                HEREDOC
          
    end #/menu
    
    def self.welcome_msg
        #Other Fonts: ANSI Shadow, Larry 3D 2, Modular,Red Phoenix, Sub-Zero
        welcome_banner = RubyFiglet::Figlet.new " PreFlight\n   Weather", 'Sub-Zero'
       
        welcome_banner.show
        print "\n\nPlease, enter your name to begin: "
        name = gets.strip
        puts "\nHello #{name}, Welcome to your PreFlight information and Weather Check!\n\n"
        puts "Please, select an option below."
    end
end
