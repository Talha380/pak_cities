# frozen_string_literal: true

require "test_helper"

class TestPakCities < Minitest::Test
  def setup
    PakCities.reset_configuration!
  end

  def teardown
    PakCities.reset_configuration!
  end

  def test_integration_find_and_distance
    karachi = PakCities.find("Karachi")
    lahore = PakCities.find("Lahore")

    refute_nil karachi
    refute_nil lahore

    distance = PakCities.distance_between(karachi.name, lahore.name)
    assert distance.positive?
  end

  def test_integration_search_and_filter
    cities = PakCities.search("abad")
    refute_empty cities

    punjab_cities = cities.select { |city| city.province == "Punjab" }
    refute_empty punjab_cities
  end

  def test_integration_configuration_affects_distance
    PakCities.configure { |config| config.distance_unit = :km }
    distance_km = PakCities.distance_between("Karachi", "Lahore")

    PakCities.configure { |config| config.distance_unit = :miles }
    distance_miles = PakCities.distance_between("Karachi", "Lahore")

    refute_equal distance_km, distance_miles
    assert distance_km > distance_miles
  end

  def test_integration_statistics_and_query
    largest = PakCities.largest_city
    top_cities = PakCities.top_by_population(1)

    assert_equal largest, top_cities.first
  end

  def test_integration_province_grouping_and_statistics
    grouped = PakCities.grouped_by_province
    pop_by_province = PakCities.population_by_province

    grouped.each do |province, cities|
      expected_pop = cities.sum(&:population)
      assert_equal expected_pop, pop_by_province[province]
    end
  end

  def test_integration_nearest_and_within_bounds
    karachi = PakCities.find("Karachi")
    nearest = PakCities.nearest_to(karachi.latitude, karachi.longitude, 10)

    within_bounds = PakCities.within_bounds(
      min_lat: karachi.latitude - 2,
      max_lat: karachi.latitude + 2,
      min_lng: karachi.longitude - 2,
      max_lng: karachi.longitude + 2
    )

    assert nearest.size <= within_bounds.size
  end

  def test_module_has_error_classes
    assert_equal PakCities::Error.superclass, StandardError
    assert_equal PakCities::CityNotFoundError.superclass, PakCities::Error
    assert_equal PakCities::InvalidCoordinatesError.superclass, PakCities::Error
    assert_equal PakCities::InvalidConfigurationError.superclass, PakCities::Error
  end
end
