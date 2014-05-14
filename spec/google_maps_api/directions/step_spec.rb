require "spec_helper"
require "google_maps_api/directions/json_response"

describe GoogleMapsAPI::Directions::Step do
  include_context "json response"

  subject { GoogleMapsAPI::Directions::Step }

  describe ".from_hash" do
    it "returns a new step" do
      hash = parsed_json["routes"].first["legs"].first["steps"].first
      expect(subject.from_hash(hash)).to be_a(subject)
    end
  end
end
