require "net/http"

class GoogleMapsAPI::Directions::Request
  BASE_PATH = "maps.googleapis.com/maps/api/directions/json"

  attr_accessor :origin, :destination, :options, :http_adapter

  def initialize(origin, destination, options = {})
    origin = origin.to_ary.join(",") if origin.respond_to?(:to_ary)
    destination = destination.to_ary.join(",") if destination.respond_to?(:to_ary)
    @origin = origin
    @destination = destination
    @options = default_options.merge(options)
    @http_adapter = nil
  end

  def self.build(origin, destination, options = {})
    self.new(origin, destination, options)
  end

  def perform
    response = http_adapter.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      return GoogleMapsAPI::Directions::Response.from_json(response.body)
    else
      msg = "The response was not successful (200). Call #response for datails."
      exception = GoogleMapsAPI::Directions::ResponseError.new(msg)
      exception.response = response
      raise exception
    end
  end

  def uri
    uri = URI("#{scheme}://#{BASE_PATH}")
    query = prepared_options.merge({origin: origin, destination: destination})
    uri.query = URI.encode_www_form(query)
    uri
  end

  def scheme
    options[:https] ? "https" : "http"
  end

  def http_adapter
    @http_adapter || Net::HTTP
  end

  private

  def default_options
    {
      sensor: false,
      mode: "driving",
      language: "en",
      units: "metric",
      region: "us"
    }
  end

  def prepared_options
    options = self.options.dup
    options[:departure_time] = time_or_date_to_unix(options[:departure_time])
    options[:arrival_time] = time_or_date_to_unix(options[:arrival_time])

    if options[:waypoints].respond_to?(:collect)
      waypoints = options[:waypoints].collect do |w|
        w.respond_to?(:to_ary) ? w.to_ary.join(",") : w
      end

      options[:waypoints] = waypoints.join("|")
    end

    options.delete_if { |key, value| value.to_s.strip.empty? }
    options
  end

  def time_or_date_to_unix(time_or_date)
    return time_or_date.to_i if time_or_date.is_a?(Time)
    return time_or_date.to_time.to_i if time_or_date.is_a?(Date)
    time_or_date
  end
end
