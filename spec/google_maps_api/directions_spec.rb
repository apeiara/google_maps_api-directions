require "spec_helper"
require "google_maps_api/directions/request_lets"

describe GoogleMapsAPI::Directions do
  subject { GoogleMapsAPI::Directions }

  include_context "request lets"

  describe ".route" do
    it "performs a request" do
      expect_any_instance_of(subject::Request).to receive(:perform).with(no_args)
      subject.route(origin, destination, options)
    end

    it "returns a response" do
      expect(subject.route(origin, destination, options)).to be_a(subject::Response)
    end
  end

end
