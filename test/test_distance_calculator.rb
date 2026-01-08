# frozen_string_literal: true

require "test_helper"

class TestDistanceCalculator < Minitest::Test
  def test_haversine_distance_in_km
    distance = PakCities::DistanceCalculator.haversine_distance(
      24.8608, 67.0104,
      31.558, 74.3507,
      unit: :km
    )
    assert_in_delta 1000, distance, 100
  end

  def test_haversine_distance_in_miles
    distance = PakCities::DistanceCalculator.haversine_distance(
      24.8608, 67.0104,
      31.558, 74.3507,
      unit: :miles
    )
    assert_in_delta 620, distance, 100
  end

  def test_haversine_distance_same_location
    distance = PakCities::DistanceCalculator.haversine_distance(
      24.8608, 67.0104,
      24.8608, 67.0104,
      unit: :km
    )
    assert_in_delta 0, distance, 0.1
  end

  def test_haversine_distance_with_invalid_coordinates
    assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities::DistanceCalculator.haversine_distance(
        91, 67.0104,
        31.558, 74.3507,
        unit: :km
      )
    end
  end

  def test_convert_distance_km_to_km
    distance = PakCities::DistanceCalculator.convert_distance(100, :km)
    assert_equal 100, distance
  end

  def test_convert_distance_km_to_miles
    distance = PakCities::DistanceCalculator.convert_distance(100, :miles)
    assert_in_delta 62.1371, distance, 0.001
  end

  def test_convert_distance_with_invalid_unit
    assert_raises(ArgumentError) do
      PakCities::DistanceCalculator.convert_distance(100, :invalid)
    end
  end
end
