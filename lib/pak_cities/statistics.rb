# frozen_string_literal: true

module PakCities
  module Statistics
    def total_population
      cities.sum(&:population)
    end

    def average_population
      return 0 if cities.empty?

      total_population / cities.size.to_f
    end

    def median_population
      return 0 if cities.empty?

      sorted = cities.map(&:population).sort
      mid = sorted.size / 2
      sorted.size.odd? ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2.0
    end

    def population_by_province
      grouped_by_province.transform_values do |cities_in_province|
        cities_in_province.sum(&:population)
      end
    end

    def cities_count_by_province
      grouped_by_province.transform_values(&:size)
    end

    def largest_city
      cities.max_by(&:population)
    end

    def smallest_city
      cities.min_by(&:population)
    end
  end
end
