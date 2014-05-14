require "google_maps_api/directions/version"
require "google_maps_api/core"
require "google_maps_api/directions/request"
require "google_maps_api/directions/route"
require "google_maps_api/directions/bounds"
require "google_maps_api/directions/leg"
require "google_maps_api/directions/step"
require "google_maps_api/directions/encoded_polyline"
require "google_maps_api/directions/response"
require "google_maps_api/directions/exceptions"

module GoogleMapsAPI
  module Directions
    def self.route(origin, destination, options = {})
      request = Request.build(origin, destination, options)
      request.perform
    end
  end
end
