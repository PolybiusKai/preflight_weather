#https://avwx.rest/api/search/station?text=lihue%20hi - station search
## What does API::PreFlight mean and do?
class API
    attr_accessor :icao, :city#, :data
    
    def self.search_by_icao(icao)
        @icao = icao 
    end

    def self.search_by_city(city)
        @city = city 
    end

    def self.get_preflight_data
       res = RestClient.get "https://avwx.rest/api/metar/#{@icao}", {:Authorization => ENV["AVWX_KEY"]}
       preflight_data = parse_json(res.body)
       preflight_data 
    end

    def self.get_icao_by_location
        #:city, :icao, :latitude, :longitude, :name, :state, :type, :website
        res = RestClient.get "https://avwx.rest/api/search/station?text=#{@city}", {:Authorization => ENV["AVWX_KEY"]}
        station_data = parse_json(res.body)
        station_data[0]
        #station_data[0]["icao"] => "KLAS"
        #station_data[0]["name"]
        # icao_data = Stations.new(station_data)
        # 
    end

    def self.get_station_data
        ## Does get station data need to be in it's own API Class, or can it stay here?

    end
    def self.parse_json(parsed_data)
       preflight_info = JSON.parse(parsed_data)
    end
end

