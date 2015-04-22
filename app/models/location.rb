class Location
  def self.load_space_markers(spaces)
    Gmaps4rails.build_markers(spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.infowindow space.address
    end
  end
end
