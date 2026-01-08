# frozen_string_literal: true

module PakCities
  module Query
    def all
      cities
    end

    def count
      cities.size
    end

    def find(name)
      cities.find { |city| match_name?(city.name, name) }
    end

    def find!(name)
      find(name) || raise(CityNotFoundError, "City not found: #{name}")
    end

    def search(query)
      query = normalize_string(query)
      cities.select { |city| normalize_string(city.name).include?(query) }
    end

    def where(conditions = {})
      result = cities

      if conditions[:province]
        province = conditions[:province]
        result = result.select { |city| match_name?(city.province, province) }
      end

      result = result.select { |city| city.population >= conditions[:min_population] } if conditions[:min_population]

      result = result.select { |city| city.population <= conditions[:max_population] } if conditions[:max_population]

      result
    end

    def by_province(province)
      cities.select { |city| match_name?(city.province, province) }
    end

    def top_by_population(limit = 10)
      Validators.validate_positive_integer!(limit, "limit")
      cities.sort_by(&:population).reverse.take(limit)
    end

    def by_name(order: :asc)
      sorted = cities.sort_by(&:name)
      order == :desc ? sorted.reverse : sorted
    end

    def by_population(order: :desc)
      sorted = cities.sort_by(&:population)
      order == :desc ? sorted.reverse : sorted
    end

    def random(limit = 1)
      Validators.validate_positive_integer!(limit, "limit")
      cities.sample(limit)
    end

    def provinces
      cities.map(&:province).uniq.sort
    end

    def grouped_by_province
      cities.group_by(&:province)
    end

    def nearest_to(lat, lng, limit = 5)
      Validators.validate_coordinates!(lat, lng)
      Validators.validate_positive_integer!(limit, "limit")

      unit = configuration.distance_unit

      cities_with_distance = cities.map do |city|
        distance = DistanceCalculator.haversine_distance(
          lat, lng, city.latitude, city.longitude, unit: unit
        )
        [city, distance]
      end

      cities_with_distance.sort_by { |_, distance| distance }.take(limit).map(&:first)
    end

    def within_bounds(min_lat:, max_lat:, min_lng:, max_lng:)
      Validators.validate_coordinates!(min_lat, min_lng)
      Validators.validate_coordinates!(max_lat, max_lng)

      cities.select do |city|
        city.latitude.between?(min_lat, max_lat) &&
          city.longitude.between?(min_lng, max_lng)
      end
    end

    def distance_between(city1_name, city2_name)
      city1 = find!(city1_name)
      city2 = find!(city2_name)

      DistanceCalculator.haversine_distance(
        city1.latitude, city1.longitude,
        city2.latitude, city2.longitude,
        unit: configuration.distance_unit
      )
    end

    def same_province?(city1_name, city2_name)
      city1 = find!(city1_name)
      city2 = find!(city2_name)
      city1.province == city2.province
    end

    def reload!
      @cities = nil
      cities
    end

    private

    def match_name?(str1, str2)
      if configuration.case_sensitive
        str1 == str2
      else
        str1.downcase == str2.downcase
      end
    end

    def normalize_string(str)
      configuration.case_sensitive ? str : str.downcase
    end
  end
end
