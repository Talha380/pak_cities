# frozen_string_literal: true

module PakCities
  class Error < StandardError; end
  class CityNotFoundError < Error; end
  class InvalidCoordinatesError < Error; end
  class InvalidConfigurationError < Error; end
end
