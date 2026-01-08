# frozen_string_literal: true

require "test_helper"

class TestCity < Minitest::Test
  def setup
    @city = PakCities::City.new(
      name: "Karachi",
      province: "Sindh",
      latitude: 24.8608,
      longitude: 67.0104,
      population: 11_624_219
    )
  end

  def test_city_has_name
    assert_equal "Karachi", @city.name
  end

  def test_city_has_province
    assert_equal "Sindh", @city.province
  end

  def test_city_has_latitude
    assert_equal 24.8608, @city.latitude
  end

  def test_city_has_longitude
    assert_equal 67.0104, @city.longitude
  end

  def test_city_has_population
    assert_equal 11_624_219, @city.population
  end

  def test_to_s_returns_formatted_string
    assert_equal "Karachi, Sindh", @city.to_s
  end

  def test_to_h_returns_hash
    hash = @city.to_h
    assert_equal "Karachi", hash[:name]
    assert_equal "Sindh", hash[:province]
    assert_equal 24.8608, hash[:latitude]
    assert_equal 67.0104, hash[:longitude]
    assert_equal 11_624_219, hash[:population]
  end

  def test_inspect_returns_formatted_string
    expected = '#<PakCities::City name="Karachi" province="Sindh" ' \
               "latitude=24.8608 longitude=67.0104 population=11624219>"
    assert_equal expected, @city.inspect
  end

  def test_equality_with_same_city
    city2 = PakCities::City.new(
      name: "Karachi",
      province: "Sindh",
      latitude: 24.8608,
      longitude: 67.0104,
      population: 11_624_219
    )
    assert_equal @city, city2
  end

  def test_inequality_with_different_city
    city2 = PakCities::City.new(
      name: "Lahore",
      province: "Punjab",
      latitude: 31.558,
      longitude: 74.3507,
      population: 6_310_888
    )
    refute_equal @city, city2
  end

  def test_hash_method
    city2 = PakCities::City.new(
      name: "Karachi",
      province: "Sindh",
      latitude: 24.8608,
      longitude: 67.0104,
      population: 11_624_219
    )
    assert_equal @city.hash, city2.hash
  end

  def test_converts_latitude_to_float
    city = PakCities::City.new(
      name: "Test",
      province: "Test",
      latitude: "24.8608",
      longitude: 67.0104,
      population: 1000
    )
    assert_instance_of Float, city.latitude
  end

  def test_converts_longitude_to_float
    city = PakCities::City.new(
      name: "Test",
      province: "Test",
      latitude: 24.8608,
      longitude: "67.0104",
      population: 1000
    )
    assert_instance_of Float, city.longitude
  end

  def test_converts_population_to_integer
    city = PakCities::City.new(
      name: "Test",
      province: "Test",
      latitude: 24.8608,
      longitude: 67.0104,
      population: "1000"
    )
    assert_instance_of Integer, city.population
  end
end
