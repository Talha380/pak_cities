# frozen_string_literal: true

module PakCities
  module Validators
    LATITUDE_RANGE = (-90..90).freeze
    LONGITUDE_RANGE = (-180..180).freeze

    module_function

    def validate_coordinates!(latitude, longitude)
      unless LATITUDE_RANGE.cover?(latitude)
        raise InvalidCoordinatesError, "Latitude must be between -90 and 90, got #{latitude}"
      end

      return if LONGITUDE_RANGE.cover?(longitude)

      raise InvalidCoordinatesError, "Longitude must be between -180 and 180, got #{longitude}"
    end

    def validate_positive_integer!(value, name)
      return if value.is_a?(Integer) && value.positive?

      raise ArgumentError, "#{name} must be a positive integer, got #{value.inspect}"
    end
  end
end
