# frozen_string_literal: true

require "test_helper"

class TestStatistics < Minitest::Test
  def test_total_population
    total = PakCities.total_population
    assert_instance_of Integer, total
    assert total.positive?
  end

  def test_average_population
    average = PakCities.average_population
    assert_instance_of Float, average
    assert average.positive?
  end

  def test_median_population
    median = PakCities.median_population
    assert_kind_of Numeric, median
    assert median.positive?
  end

  def test_population_by_province
    pop_by_province = PakCities.population_by_province
    assert_instance_of Hash, pop_by_province
    refute_empty pop_by_province

    pop_by_province.each do |province, population|
      assert_instance_of String, province
      assert_instance_of Integer, population
      assert population.positive?
    end
  end

  def test_cities_count_by_province
    count_by_province = PakCities.cities_count_by_province
    assert_instance_of Hash, count_by_province
    refute_empty count_by_province

    count_by_province.each do |province, count|
      assert_instance_of String, province
      assert_instance_of Integer, count
      assert count.positive?
    end
  end

  def test_largest_city
    largest = PakCities.largest_city
    assert_instance_of PakCities::City, largest
    assert_equal "Karachi", largest.name
  end

  def test_smallest_city
    smallest = PakCities.smallest_city
    assert_instance_of PakCities::City, smallest
    assert smallest.population < PakCities.largest_city.population
  end

  def test_total_population_equals_sum_of_province_populations
    total = PakCities.total_population
    province_sum = PakCities.population_by_province.values.sum
    assert_equal total, province_sum
  end

  def test_count_equals_sum_of_cities_by_province
    total_count = PakCities.count
    province_count_sum = PakCities.cities_count_by_province.values.sum
    assert_equal total_count, province_count_sum
  end
end
