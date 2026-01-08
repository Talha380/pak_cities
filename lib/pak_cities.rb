# frozen_string_literal: true

require_relative "pak_cities/version"
require_relative "pak_cities/errors"
require_relative "pak_cities/configuration"
require_relative "pak_cities/validators"
require_relative "pak_cities/city"
require_relative "pak_cities/distance_calculator"
require_relative "pak_cities/query"
require_relative "pak_cities/statistics"
require "json"

module PakCities
  DATA_FILE = File.join(__dir__, "pak_cities", "data.json")

  class << self
    include Query
    include Statistics

    private

    def cities
      @cities ||= load_cities
    end

    def load_cities
      data = JSON.parse(File.read(DATA_FILE))
      data.map do |city_data|
        City.new(
          name: city_data["city"],
          province: city_data["province"],
          latitude: city_data["latitude"],
          longitude: city_data["longitude"],
          population: city_data["pop2025"]
        )
      end
    end
  end
end
