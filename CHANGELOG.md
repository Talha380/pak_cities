# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-01-08

### Added

- Initial release of Pak Cities gem
- City class with proper methods (`to_s`, `to_h`, `inspect`, `==`, `hash`)
- Comprehensive query methods:
  - `all` - Get all cities
  - `count` - Total number of cities
  - `find(name)` - Find city by name
  - `find!(name)` - Find city or raise error
  - `search(query)` - Fuzzy search by city name
  - `where(conditions)` - Filter by multiple criteria
  - `by_province(province)` - Get cities in a province
  - `top_by_population(limit)` - Top cities by population
  - `by_name(order:)` - Sort cities by name
  - `by_population(order:)` - Sort cities by population
  - `random(limit)` - Get random cities
  - `provinces` - List all provinces
  - `grouped_by_province` - Group cities by province
  - `nearest_to(lat, lng, limit)` - Find nearest cities
  - `within_bounds(...)` - Cities within bounding box
  - `distance_between(city1, city2)` - Distance between two cities
  - `same_province?(city1, city2)` - Check if same province
  - `reload!` - Reload city data
- Statistical methods:
  - `total_population` - Sum of all populations
  - `average_population` - Average population
  - `median_population` - Median population
  - `population_by_province` - Population per province
  - `cities_count_by_province` - City count per province
  - `largest_city` - City with largest population
  - `smallest_city` - City with smallest population
- Configuration system:
  - Configurable distance units (km/miles)
  - Configurable case sensitivity
- Distance calculator with Haversine formula
- Input validation for coordinates and parameters
- Custom error classes:
  - `CityNotFoundError`
  - `InvalidCoordinatesError`
  - `InvalidConfigurationError`
- Comprehensive test suite (100 tests, 227 assertions)
- Full RuboCop compliance
- Support for Ruby >= 2.7.0
- Professional documentation and README

[0.1.0]: https://github.com/Talha380/pak_cities/releases/tag/v0.1.0
