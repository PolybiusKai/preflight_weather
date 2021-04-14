class API
    attr_accessor :icao

    def self.search_by_icao(icao)
        @icao = icao 
    end

    def self.get_preflight_data
       res = RestClient.get "https://avwx.rest/api/metar/#{@icao}", {:Authorization => ENV["AVWX_KEY"]}
       preflight_data = parse_json(res.body)
       preflight_data 
    end

    def self.get_station_by_icao
        res = RestClient.get "https://avwx.rest/api/search/station?text=#{@icao}", {:Authorization => ENV["AVWX_KEY"]}
        station_data = parse_json(res.body)
        station_data[0]
    end

    def self.parse_json(parsed_data)
       preflight_info = JSON.parse(parsed_data)
    end
end

