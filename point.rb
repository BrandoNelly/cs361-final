class Point

  attr_reader :lat, :lon, :elevation

  def initialize(lon, lat, elevation=nil)
    @lon = lon
    @lat = lat
    @elevation = elevation
  end
end