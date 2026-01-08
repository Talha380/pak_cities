# frozen_string_literal: true

module PakCities
  class Configuration
    attr_accessor :case_sensitive
    attr_reader :distance_unit

    VALID_DISTANCE_UNITS = %i[km miles].freeze

    def initialize
      @distance_unit = :km
      @case_sensitive = false
    end

    def distance_unit=(unit)
      unit = unit.to_sym
      unless VALID_DISTANCE_UNITS.include?(unit)
        raise InvalidConfigurationError, "Invalid distance unit: #{unit}. Must be :km or :miles"
      end

      @distance_unit = unit
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end
