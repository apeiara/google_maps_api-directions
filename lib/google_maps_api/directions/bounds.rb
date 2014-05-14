class GoogleMapsAPI::Directions::Bounds
  attr_reader :northeast, :southwest

  def initialize(northeast, southwest)
    @northeast = northeast
    @southwest = southwest
    self
  end

  def self.from_hash(hash)
    northeast = build_coordinate(hash["northeast"])
    southwest = build_coordinate(hash["southwest"])
    self.new(northeast, southwest)
  end

  private

  def self.build_coordinate(hash)
    GoogleMapsAPI::Core::Coordinate.from_hash(hash)
  end
end
