# frozen_string_literal: true

require "test_helper"

class TestConfiguration < Minitest::Test
  def setup
    PakCities.reset_configuration!
  end

  def teardown
    PakCities.reset_configuration!
  end

  def test_default_distance_unit_is_km
    assert_equal :km, PakCities.configuration.distance_unit
  end

  def test_default_case_sensitive_is_false
    assert_equal false, PakCities.configuration.case_sensitive
  end

  def test_configure_distance_unit_to_miles
    PakCities.configure do |config|
      config.distance_unit = :miles
    end
    assert_equal :miles, PakCities.configuration.distance_unit
  end

  def test_configure_case_sensitive_to_true
    PakCities.configure do |config|
      config.case_sensitive = true
    end
    assert_equal true, PakCities.configuration.case_sensitive
  end

  def test_distance_unit_accepts_string
    PakCities.configure do |config|
      config.distance_unit = "km"
    end
    assert_equal :km, PakCities.configuration.distance_unit
  end

  def test_invalid_distance_unit_raises_error
    error = assert_raises(PakCities::InvalidConfigurationError) do
      PakCities.configure do |config|
        config.distance_unit = :invalid
      end
    end
    assert_match(/Invalid distance unit/, error.message)
  end

  def test_reset_configuration
    PakCities.configure do |config|
      config.distance_unit = :miles
      config.case_sensitive = true
    end

    PakCities.reset_configuration!

    assert_equal :km, PakCities.configuration.distance_unit
    assert_equal false, PakCities.configuration.case_sensitive
  end
end
