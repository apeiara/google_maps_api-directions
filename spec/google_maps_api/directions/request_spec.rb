require "spec_helper"
require "google_maps_api/directions/request_lets"

describe GoogleMapsAPI::Directions::Request do

  include_context "request lets"

  subject { GoogleMapsAPI::Directions::Request.new(origin, destination, options) }

  describe ".build" do
    subject { GoogleMapsAPI::Directions::Request }

    it "builds a new request" do
      expect(subject.build(origin, destination, options)).to be_a(subject)
    end
  end

  describe "#perform" do
    it "returns a response" do
      expect(subject.perform).to be_a(GoogleMapsAPI::Directions::Response)
    end

    it "raises a ResponseError if the response is not successful" do
      allow(subject.http_adapter).to receive(:get_response).and_return(false)
      expect { subject.perform }.to raise_error(GoogleMapsAPI::Directions::ResponseError)
    end
  end

  describe "#uri" do
    it "returns a URI" do
      expect(subject.uri).to be_a(URI)
    end
  end

  describe "#scheme" do
    context "when https option is true" do
      subject { GoogleMapsAPI::Directions::Request.new(origin, destination, {https: true}) }

      it "returns 'https'" do
        expect(subject.scheme).to eq('https')
      end
    end

    context "when https option is false" do
      subject { GoogleMapsAPI::Directions::Request.new(origin, destination, {https: false}) }

      it "returns 'http'" do
        expect(subject.scheme).to eq('http')
      end
    end
  end
end
