require "spec_helper"
require "google_maps_api/directions/json_response"

describe GoogleMapsAPI::Directions::Response do
  include_context "json response"

  subject { GoogleMapsAPI::Directions::Response }

  describe ".from_json" do
    it "returns a new response" do
      expect(subject.from_json(json)).to be_a(subject)
    end
  end
end
