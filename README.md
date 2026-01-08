# PakCities

A professional Ruby gem providing comprehensive access to Pakistan cities data with powerful query methods, statistical analysis, and configurable options. Search cities by name, province, population, or find nearest cities by coordinates.

[![Ruby](https://img.shields.io/badge/ruby-%3E%3D%202.7.0-ruby.svg)](https://www.ruby-lang.org/)
[![Gem Version](https://badge.fury.io/rb/pak_cities.svg)](https://badge.fury.io/rb/pak_cities)

## Features

- 🔍 **Comprehensive Query Methods** - Find, search, filter cities with ease
- 📊 **Statistical Analysis** - Population statistics, averages, medians
- 📍 **Geographic Calculations** - Find nearest cities, calculate distances
- ⚙️ **Configurable** - Distance units (km/miles), case sensitivity
- 🧪 **Well Tested** - 100% test coverage with 100+ tests
- 📝 **Professional Code** - Clean architecture, modular design
- 🚀 **Ruby 2.7+** - Compatible with modern Ruby versions

## Installation

Add this line to your application's Gemfile:

```ruby
gem "pak_cities"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install pak_cities
```

## Usage

### Basic Queries

```ruby
require "pak_cities"

PakCities.all
PakCities.count

city = PakCities.find("Karachi")
city.name
city.province
city.latitude
city.longitude
city.population
```

### Search and Filter

```ruby
PakCities.search("Lah")

PakCities.where(province: "Punjab")
PakCities.where(min_population: 1_000_000)
PakCities.where(max_population: 500_000)
PakCities.where(province: "Sindh", min_population: 1_000_000)

PakCities.by_province("Punjab")
```

### Population Queries

```ruby
PakCities.top_by_population
PakCities.top_by_population(5)

PakCities.by_population(order: :desc)
PakCities.by_population(order: :asc)
```

### Sorting

```ruby
PakCities.by_name(order: :asc)
PakCities.by_name(order: :desc)
```

### Random Selection

```ruby
PakCities.random
PakCities.random(5)
```

### Province Operations

```ruby
PakCities.provinces

PakCities.grouped_by_province

PakCities.same_province?("Karachi", "Hyderabad")
```

### Geographic Queries

```ruby
PakCities.nearest_to(24.8608, 67.0104)
PakCities.nearest_to(31.558, 74.3507, 3)

PakCities.within_bounds(
  min_lat: 24.0, max_lat: 26.0,
  min_lng: 67.0, max_lng: 69.0
)

PakCities.distance_between("Karachi", "Lahore")
```

### Statistical Methods

```ruby
PakCities.total_population
PakCities.average_population
PakCities.median_population

PakCities.population_by_province
PakCities.cities_count_by_province

PakCities.largest_city
PakCities.smallest_city
```

### Configuration

```ruby
PakCities.configure do |config|
  config.distance_unit = :miles
  config.case_sensitive = true
end

PakCities.reset_configuration!
```

### Error Handling

```ruby
begin
  city = PakCities.find!("NonexistentCity")
rescue PakCities::CityNotFoundError => e
  puts e.message
end

begin
  PakCities.nearest_to(91, 67.0104)
rescue PakCities::InvalidCoordinatesError => e
  puts e.message
end
```

## API Reference

### Query Methods

| Method | Description | Returns |
|--------|-------------|---------|
| `all` | Get all cities | Array<City> |
| `count` | Total number of cities | Integer |
| `find(name)` | Find city by name (case-insensitive) | City or nil |
| `find!(name)` | Find city or raise error | City |
| `search(query)` | Fuzzy search by city name | Array<City> |
| `where(conditions)` | Filter by multiple criteria | Array<City> |
| `by_province(province)` | Get cities in a province | Array<City> |
| `top_by_population(limit)` | Top cities by population | Array<City> |
| `by_name(order:)` | Sort cities by name | Array<City> |
| `by_population(order:)` | Sort cities by population | Array<City> |
| `random(limit)` | Get random cities | Array<City> |
| `provinces` | List all provinces | Array<String> |
| `grouped_by_province` | Group cities by province | Hash |
| `nearest_to(lat, lng, limit)` | Find nearest cities | Array<City> |
| `within_bounds(...)` | Cities within bounding box | Array<City> |
| `distance_between(city1, city2)` | Distance between two cities | Float |
| `same_province?(city1, city2)` | Check if same province | Boolean |
| `reload!` | Reload city data | Array<City> |

### Statistical Methods

| Method | Description | Returns |
|--------|-------------|---------|
| `total_population` | Sum of all populations | Integer |
| `average_population` | Average population | Float |
| `median_population` | Median population | Numeric |
| `population_by_province` | Population per province | Hash |
| `cities_count_by_province` | City count per province | Hash |
| `largest_city` | City with largest population | City |
| `smallest_city` | City with smallest population | City |

### Configuration Options

| Option | Values | Default | Description |
|--------|--------|---------|-------------|
| `distance_unit` | `:km`, `:miles` | `:km` | Unit for distance calculations |
| `case_sensitive` | `true`, `false` | `false` | Case sensitivity for searches |

### City Attributes

| Attribute | Type | Description |
|-----------|------|-------------|
| `name` | String | City name |
| `province` | String | Province name |
| `latitude` | Float | Geographic latitude |
| `longitude` | Float | Geographic longitude |
| `population` | Integer | Population (2025 estimate) |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Talha380/pak_cities. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Talha380/pak_cities/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PakCities project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Talha380/pak_cities/blob/master/CODE_OF_CONDUCT.md).
