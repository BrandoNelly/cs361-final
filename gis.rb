#!/usr/bin/env ruby

class Track
  def initialize(segments, name=nil)
    @name = name
    segment_objects = []
    segments.each do |segment|
      segment_objects.append(TrackSegment.new(segment))
    end
    # set segments to segment_objects
    @segments = segment_objects
  end

  def get_track_json()
    j = '{'
    j += '"type": "Feature", '
    if @name != nil
      j+= '"properties": {'
      j += '"title": "' + @name + '"'
      j += '},'
    end
    j += '"geometry": {'
    j += '"type": "MultiLineString",'
    j +='"coordinates": ['
    # Loop through all the segment objects
    @segments.each_with_index do |segment, index|
      if index > 0
        j += ","
      end
      j += '['
      # Loop through all the coordinates in the segment
      tsj = ''
      segment.coordinates.each do |coordinate|
        if tsj != ''
          tsj += ','
        end
        # Add the coordinate
        tsj += '['
        tsj += "#{coordinate.lon},#{coordinate.lat}"
        if coordinate.elevation != nil
          tsj += ",#{coordinate.elevation}"
        end
        tsj += ']'
      end
      j+=tsj
      j+=']'
    end
    j + ']}}'
  end
end
class TrackSegment
  attr_reader :coordinates
  def initialize(coordinates)
    @coordinates = coordinates
  end
end

class Point

  attr_reader :lat, :lon, :elevation

  def initialize(lon, lat, elevation=nil)
    @lon = lon
    @lat = lat
    @elevation = elevation
  end
end

class Waypoint

attr_reader :lat, :lon, :elevation, :name, :type

  def initialize(lon, lat, elevation=nil, name=nil, type=nil)
	
    @lat = lat
    @lon = lon
    @elevation = elevation
    @name = name
    @type = type
  end

  def get_waypoint_json(indent=0)
    j = '{"type": "Feature",'
    # if name is not nil or type is not nil
    j += '"geometry": {"type": "Point","coordinates": '
    j += "[#{@lon},#{@lat}"
    if elevation != nil
      j += ",#{@elevation}"
    end
    j += ']},'
    if name != nil or type != nil
      j += '"properties": {'
      if name != nil
        j += '"title": "' + @name + '"'
      end
      if type != nil  # if type is not nil
        if name != nil
          j += ','
        end
        j += '"icon": "' + @type + '"'  # type is the icon
      end
      j += '}'
    end
    j += "}"
    return j
  end
end

class World
def initialize(name, features)
  @name = name
  @features = features
end
  def add_feature(feature)
    @features.append(track)
  end

  def to_geojson(indent=0)
    # Write stuff
    segment = '{"type": "FeatureCollection","features": ['
    @features.each_with_index do |feature,index|
      if index != 0
        segment +=","
      end
        if feature.class == Track
            segment += feature.get_track_json
        elsif feature.class == Waypoint
            segment += feature.get_waypoint_json
      end
    end
    segment + "]}"
  end
end

def main()
  waypoint1 = Waypoint.new(-121.5, 45.5, 30, "home", "flag")
  waypoint2 = Waypoint.new(-121.5, 45.6, nil, "store", "dot")
  
  track_segment1 = [ Point.new(-122, 45), Point.new(-122, 46), Point.new(-121, 46),]
  track_segment2 = [ Point.new(-121, 45), Point.new(-121, 46),]
  track_segment3 = [Point.new(-121, 45.5), Point.new(-122, 45.5),]

  track1 = Track.new([track_segment1, track_segment2], "track 1")
  track2 = Track.new([track_segment3], "track 2")

  world = World.new("My Data", [waypoint1, waypoint2, track1, track2])

  puts world.to_geojson()
  
end

if File.identical?(__FILE__, $0)
  main()
end

