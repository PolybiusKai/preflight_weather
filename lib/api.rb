require_relative './env.rb'

class API
    attr_accessor :location#, :data
    
    def self.find_by_location(location)
        @location = location 
    end

    def self.get_preflight_data
       res = RestClient.get "https://avwx.rest/api/metar/#{@location}", {:Authorization => ENV["AVWX_KEY"]}
       parse_json(res.body)
    end


    def self.parse_json(parsed_data)
       preflight_info = JSON.parse(parsed_data)
       puts preflight_info
       binding.pry
    end
end


