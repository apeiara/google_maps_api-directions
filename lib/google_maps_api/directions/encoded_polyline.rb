class GoogleMapsAPI::Directions::EncodedPolyline
  attr_reader :encoded

  def initialize(encoded)
    @encoded = encoded
  end

  def coordinates
    @coordinates ||= decode
    @coordinates
  end

  def to_s
    encoded
  end

  private

  def decode
    begin
      require "polylines" unless defined?(Polylines)
      array = Polylines::Decoder.decode_polyline(encoded)
      return array.collect do |c|
        GoogleMapsAPI::Core::Coordinate.from_array(c)
      end
    rescue LoadError
      raise "You need to install and require the 'polylines' (https://rubygems.org/gems/polylines) gem in your Gemfile if you want to use this method"
    end
  end
end
