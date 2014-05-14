class GoogleMapsAPI::Directions::Error < StandardError; end

class GoogleMapsAPI::Directions::ResponseError < GoogleMapsAPI::Directions::Error
  attr_accessor :response
end
