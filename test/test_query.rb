# frozen_string_literal: true

require "test_helper"

class TestQuery < Minitest::Test
  def setup
    PakCities.reset_configuration!
  end

  def teardown
    PakCities.reset_configuration!
  end

  def test_all_returns_array_of_cities
    cities = PakCities.all
    assert_instance_of Array, cities
    refute_empty cities
    assert_instance_of PakCities::City, cities.first
  end

  def test_count_returns_total_cities
    count = PakCities.count
    assert_instance_of Integer, count
    assert count.positive?
  end

  def test_find_returns_city_by_name
    city = PakCities.find("Karachi")
    assert_instance_of PakCities::City, city
    assert_equal "Karachi", city.name
  end

  def test_find_is_case_insensitive_by_default
    city1 = PakCities.find("karachi")
    city2 = PakCities.find("KARACHI")
    assert_equal city1, city2
  end

  def test_find_returns_nil_for_nonexistent_city
    city = PakCities.find("NonexistentCity")
    assert_nil city
  end

  def test_find_bang_returns_city
    city = PakCities.find!("Karachi")
    assert_instance_of PakCities::City, city
  end

  def test_find_bang_raises_error_for_nonexistent_city
    error = assert_raises(PakCities::CityNotFoundError) do
      PakCities.find!("NonexistentCity")
    end
    assert_match(/City not found/, error.message)
  end

  def test_search_returns_matching_cities
    cities = PakCities.search("Lah")
    refute_empty cities
    assert(cities.all? { |city| city.name.downcase.include?("lah") })
  end

  def test_search_is_case_insensitive_by_default
    cities1 = PakCities.search("lah")
    cities2 = PakCities.search("LAH")
    assert_equal cities1.size, cities2.size
  end

  def test_search_returns_empty_for_no_matches
    cities = PakCities.search("XYZ123")
    assert_empty cities
  end

  def test_where_filters_by_province
    cities = PakCities.where(province: "Punjab")
    refute_empty cities
    assert(cities.all? { |city| city.province == "Punjab" })
  end

  def test_where_filters_by_min_population
    cities = PakCities.where(min_population: 10_000_000)
    refute_empty cities
    assert(cities.all? { |city| city.population >= 10_000_000 })
  end

  def test_where_filters_by_max_population
    cities = PakCities.where(max_population: 100_000)
    refute_empty cities
    assert(cities.all? { |city| city.population <= 100_000 })
  end

  def test_where_filters_by_multiple_conditions
    cities = PakCities.where(
      province: "Punjab",
      min_population: 1_000_000,
      max_population: 10_000_000
    )
    refute_empty cities
    assert(cities.all? do |city|
      city.province == "Punjab" &&
        city.population >= 1_000_000 &&
        city.population <= 10_000_000
    end)
  end

  def test_by_province_returns_cities_for_province
    cities = PakCities.by_province("Sindh")
    refute_empty cities
    assert(cities.all? { |city| city.province == "Sindh" })
  end

  def test_by_province_is_case_insensitive_by_default
    cities1 = PakCities.by_province("sindh")
    cities2 = PakCities.by_province("SINDH")
    assert_equal cities1.size, cities2.size
  end

  def test_top_by_population_returns_default_limit
    cities = PakCities.top_by_population
    assert_equal 10, cities.size
  end

  def test_top_by_population_respects_custom_limit
    cities = PakCities.top_by_population(5)
    assert_equal 5, cities.size
  end

  def test_top_by_population_sorted_descending
    cities = PakCities.top_by_population(20)
    populations = cities.map(&:population)
    assert_equal populations, populations.sort.reverse
  end

  def test_top_by_population_validates_positive_integer
    assert_raises(ArgumentError) do
      PakCities.top_by_population(0)
    end
  end

  def test_by_name_ascending
    cities = PakCities.by_name(order: :asc)
    names = cities.map(&:name)
    assert_equal names, names.sort
  end

  def test_by_name_descending
    cities = PakCities.by_name(order: :desc)
    names = cities.map(&:name)
    assert_equal names, names.sort.reverse
  end

  def test_by_population_descending
    cities = PakCities.by_population(order: :desc)
    populations = cities.map(&:population)
    assert_equal populations, populations.sort.reverse
  end

  def test_by_population_ascending
    cities = PakCities.by_population(order: :asc)
    populations = cities.map(&:population)
    assert_equal populations, populations.sort
  end

  def test_random_returns_one_city_by_default
    cities = PakCities.random
    assert_equal 1, cities.size
    assert_instance_of PakCities::City, cities.first
  end

  def test_random_returns_multiple_cities
    cities = PakCities.random(5)
    assert_equal 5, cities.size
  end

  def test_random_validates_positive_integer
    assert_raises(ArgumentError) do
      PakCities.random(-1)
    end
  end

  def test_provinces_returns_unique_provinces
    provinces = PakCities.provinces
    assert_instance_of Array, provinces
    refute_empty provinces
    assert_equal provinces.uniq, provinces
  end

  def test_provinces_are_sorted
    provinces = PakCities.provinces
    assert_equal provinces, provinces.sort
  end

  def test_grouped_by_province_returns_hash
    grouped = PakCities.grouped_by_province
    assert_instance_of Hash, grouped
    refute_empty grouped
  end

  def test_grouped_by_province_has_correct_structure
    grouped = PakCities.grouped_by_province
    grouped.each do |province, cities|
      assert_instance_of String, province
      assert_instance_of Array, cities
      assert(cities.all? { |city| city.province == province })
    end
  end

  def test_nearest_to_returns_default_limit
    cities = PakCities.nearest_to(24.8608, 67.0104)
    assert_equal 5, cities.size
  end

  def test_nearest_to_respects_custom_limit
    cities = PakCities.nearest_to(24.8608, 67.0104, 3)
    assert_equal 3, cities.size
  end

  def test_nearest_to_karachi_coordinates
    cities = PakCities.nearest_to(24.8608, 67.0104, 1)
    assert_equal "Karachi", cities.first.name
  end

  def test_nearest_to_validates_coordinates
    assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities.nearest_to(91, 67.0104)
    end
  end

  def test_nearest_to_validates_limit
    assert_raises(ArgumentError) do
      PakCities.nearest_to(24.8608, 67.0104, 0)
    end
  end

  def test_nearest_to_uses_configured_distance_unit
    PakCities.configure { |config| config.distance_unit = :miles }
    cities = PakCities.nearest_to(24.8608, 67.0104, 1)
    assert_equal "Karachi", cities.first.name
  end

  def test_within_bounds_returns_cities_in_bounds
    cities = PakCities.within_bounds(
      min_lat: 24.0, max_lat: 26.0,
      min_lng: 67.0, max_lng: 69.0
    )
    refute_empty cities
    assert(cities.all? do |city|
      city.latitude.between?(24.0, 26.0) &&
        city.longitude.between?(67.0, 69.0)
    end)
  end

  def test_within_bounds_validates_coordinates
    assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities.within_bounds(
        min_lat: -91, max_lat: 26.0,
        min_lng: 67.0, max_lng: 69.0
      )
    end
  end

  def test_distance_between_two_cities
    distance = PakCities.distance_between("Karachi", "Lahore")
    assert_instance_of Float, distance
    assert distance.positive?
  end

  def test_distance_between_raises_error_for_nonexistent_city
    assert_raises(PakCities::CityNotFoundError) do
      PakCities.distance_between("Karachi", "NonexistentCity")
    end
  end

  def test_distance_between_uses_configured_distance_unit
    PakCities.configure { |config| config.distance_unit = :km }
    distance_km = PakCities.distance_between("Karachi", "Lahore")

    PakCities.configure { |config| config.distance_unit = :miles }
    distance_miles = PakCities.distance_between("Karachi", "Lahore")

    assert distance_km > distance_miles
  end

  def test_same_province_returns_true_for_same_province
    result = PakCities.same_province?("Karachi", "Hyderabad")
    assert_equal true, result
  end

  def test_same_province_returns_false_for_different_province
    result = PakCities.same_province?("Karachi", "Lahore")
    assert_equal false, result
  end

  def test_same_province_raises_error_for_nonexistent_city
    assert_raises(PakCities::CityNotFoundError) do
      PakCities.same_province?("Karachi", "NonexistentCity")
    end
  end

  def test_reload_clears_cache
    cities1 = PakCities.all
    cities2 = PakCities.reload!
    assert_equal cities1.size, cities2.size
  end

  def test_case_sensitive_configuration
    PakCities.configure { |config| config.case_sensitive = true }
    city = PakCities.find("karachi")
    assert_nil city

    city = PakCities.find("Karachi")
    refute_nil city
  end
end
