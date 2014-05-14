require "spec_helper"
require "google_maps_api/directions/json_response"

describe GoogleMapsAPI::Directions::Route do
  include_context "json response"

  subject { GoogleMapsAPI::Directions::Route }

  describe ".from_hash" do
    it "returns a new route" do
      expect(subject.from_hash(parsed_json["routes"].first)).to be_a(subject)
    end
  end
end
