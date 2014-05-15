require "net/http"

class GoogleMapsAPI::Directions::Request
  BASE_PATH = "/maps/api/directions/json"

  attr_accessor :origin, :destination, :options, :http_adapter

  def initialize(origin, destination, options = {})
    origin = origin.to_ary.join(",") if origin.respond_to?(:to_ary)
    destination = destination.to_ary.join(",") if destination.respond_to?(:to_ary)
    @origin = origin
    @destination = destination
    @options = options
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
    base_host = GoogleMapsAPI::Core::BASE_HOST
    uri = "#{scheme}://#{base_host}#{BASE_PATH}"
    query_params = prepared_options.merge(
      {origin: origin, destination: destination}
    ).reject { |key, value| [:client, :channel].include?(key) }

    if business_account?
      query_params = query_params.reject { |key, value| [:key].include?(key) }
      uri = "#{uri}?#{to_query(query_params)}"
      uri = sign_uri(uri)
    else
      uri = URI("#{uri}?#{URI.encode_www_form(query_params)}")
    end

    uri
  end

  def scheme
    options[:https] ? "https" : "http"
  end

  def http_adapter
    @http_adapter || Net::HTTP
  end

  def business_account?
    options.key?(:key) && options.key?(:client)
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
    options = default_options.merge(self.options)

    # Symbolizes the options keys
    options.keys.each do |key|
      options[(key.to_sym rescue key) || key] = options.delete(key)
    end

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

  def sign_uri(uri)
    options = prepared_options
    GoogleMapsAPI::Core::URISigner.sign(
      uri.to_s, 
      options[:client], 
      options[:key], 
      options[:channel]
    )
  end

  def to_query(hash)
    hash.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
  end
end
