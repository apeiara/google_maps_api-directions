require "spec_helper"
require "google_maps_api/directions/json_response"

describe GoogleMapsAPI::Directions::Leg do
  include_context "json response"

  subject { GoogleMapsAPI::Directions::Leg }

  describe ".from_hash" do
    it "returns a new leg" do
      expect(subject.from_hash(parsed_json["routes"].first["legs"].first)).to be_a(subject)
    end
  end
end
