# frozen_string_literal: true

module PakCities
  class City
    attr_reader :name, :province, :latitude, :longitude, :population

    def initialize(name:, province:, latitude:, longitude:, population:)
      @name = name
      @province = province
      @latitude = latitude.to_f
      @longitude = longitude.to_f
      @population = population.to_i
    end

    def to_s
      "#{name}, #{province}"
    end

    def to_h
      {
        name: name,
        province: province,
        latitude: latitude,
        longitude: longitude,
        population: population
      }
    end

    def inspect
      "#<PakCities::City name=\"#{name}\" province=\"#{province}\" " \
        "latitude=#{latitude} longitude=#{longitude} population=#{population}>"
    end

    def ==(other)
      other.is_a?(City) &&
        name == other.name &&
        province == other.province
    end
    alias eql? ==

    def hash
      [name, province].hash
    end
  end
end
