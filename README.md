# GoogleMapsAPI::Directions

This is a wrapper around the Google Maps Directions API.

## Installation

Add this line to your application's Gemfile:

    gem 'google_maps_api-directions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_maps_api-directions

## Usage

```ruby
GoogleMapsAPI::Directions.route(origin, destination, options = {})
```

Origin and destination can be an a string or anything that supports ```to_ary```.
Options is a *Symbols* Hash with optional parameters. (See https://developers.google.com/maps/documentation/directions/#RequestParameters for more information).

### Examples:

```ruby
origin = "350, 5th Ave, NY"
destination = [40.777552, -73.954732]
options = {:language => 'pt'}
GoogleMapsAPI::Directions.route(origin, destination, options)
# => #<GoogleMapsAPI::Directions::Response:0x00000001f2b510...>
```

The ```GoogleMapsAPI::Directions::Response``` mimics the API JSON structure.

If you wish to call ```#coordinates``` on ```GoogleMapsAPI::Directions::EncodedPolyline``` objects,
you will need to install the https://rubygems.org/gems/polylines gem.

## Contributing

I am new to Ruby and Testing. We need better specs.

1. Fork it ( https://github.com/zavan/google_maps_api-directions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Important

* Do not touch the version;
* Write specs for new features;
* Be independent of Rails stuff;
* All specs must pass.

## Also see

* [http://github.com/zavan/google_maps_api-core](http://github.com/zavan/google_maps_api-core)
