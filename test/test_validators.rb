# frozen_string_literal: true

require "test_helper"

class TestValidators < Minitest::Test
  def test_validate_coordinates_with_valid_values
    assert_nil PakCities::Validators.validate_coordinates!(24.8608, 67.0104)
  end

  def test_validate_coordinates_with_invalid_latitude_too_high
    error = assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities::Validators.validate_coordinates!(91, 67.0104)
    end
    assert_match(/Latitude must be between -90 and 90/, error.message)
  end

  def test_validate_coordinates_with_invalid_latitude_too_low
    error = assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities::Validators.validate_coordinates!(-91, 67.0104)
    end
    assert_match(/Latitude must be between -90 and 90/, error.message)
  end

  def test_validate_coordinates_with_invalid_longitude_too_high
    error = assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities::Validators.validate_coordinates!(24.8608, 181)
    end
    assert_match(/Longitude must be between -180 and 180/, error.message)
  end

  def test_validate_coordinates_with_invalid_longitude_too_low
    error = assert_raises(PakCities::InvalidCoordinatesError) do
      PakCities::Validators.validate_coordinates!(24.8608, -181)
    end
    assert_match(/Longitude must be between -180 and 180/, error.message)
  end

  def test_validate_positive_integer_with_valid_value
    assert_nil PakCities::Validators.validate_positive_integer!(5, "limit")
  end

  def test_validate_positive_integer_with_zero
    error = assert_raises(ArgumentError) do
      PakCities::Validators.validate_positive_integer!(0, "limit")
    end
    assert_match(/limit must be a positive integer/, error.message)
  end

  def test_validate_positive_integer_with_negative
    error = assert_raises(ArgumentError) do
      PakCities::Validators.validate_positive_integer!(-5, "limit")
    end
    assert_match(/limit must be a positive integer/, error.message)
  end

  def test_validate_positive_integer_with_string
    error = assert_raises(ArgumentError) do
      PakCities::Validators.validate_positive_integer!("5", "limit")
    end
    assert_match(/limit must be a positive integer/, error.message)
  end
end
