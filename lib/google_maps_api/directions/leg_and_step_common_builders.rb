module GoogleMapsAPI::Directions::LegAndStepCommonBuilders
  def build_distance(hash)
    GoogleMapsAPI::Core::Distance.from_hash(hash["distance"])
  end

  def build_duration(hash)
    GoogleMapsAPI::Core::Duration.from_hash(hash["duration"])
  end

  def build_coordinate(hash)
    GoogleMapsAPI::Core::Coordinate.from_hash(hash)
  end  
end
