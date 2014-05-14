require "spec_helper"
require "google_maps_api/directions/json_response"

describe GoogleMapsAPI::Directions::Bounds do
  include_context "json response"

  subject { GoogleMapsAPI::Directions::Bounds }

  describe ".from_hash" do
    it "returns a new bounds object" do
      expect(subject.from_hash(parsed_json["routes"].first["bounds"])).to be_a(subject)
    end
  end
end
