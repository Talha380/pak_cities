# frozen_string_literal: true

module PakCities
  module DistanceCalculator
    EARTH_RADIUS_KM = 6371.0
    KM_TO_MILES = 0.621371

    module_function

    def haversine_distance(lat1, lon1, lat2, lon2, unit: :km)
      Validators.validate_coordinates!(lat1, lon1)
      Validators.validate_coordinates!(lat2, lon2)

      rad_per_deg = Math::PI / 180.0

      dlat = (lat2 - lat1) * rad_per_deg
      dlon = (lon2 - lon1) * rad_per_deg

      a = Math.sin(dlat / 2)**2 +
          Math.cos(lat1 * rad_per_deg) * Math.cos(lat2 * rad_per_deg) *
          Math.sin(dlon / 2)**2
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      distance_km = EARTH_RADIUS_KM * c
      convert_distance(distance_km, unit)
    end

    def convert_distance(distance_km, unit)
      case unit
      when :km
        distance_km
      when :miles
        distance_km * KM_TO_MILES
      else
        raise ArgumentError, "Invalid unit: #{unit}"
      end
    end
  end
end
