#!/usr/bin/env ruby
require_relative 'track'
require_relative 'waypoint'
require_relative 'point'
require_relative 'world'


def main()
  waypoint1 = Waypoint.new(-121.5, 45.5, 30, "home", "flag")
  waypoint2 = Waypoint.new(-121.5, 45.6, nil, "store", "dot")
  
  track_segment1 = [Point.new(-122, 45), Point.new(-122, 46), Point.new(-121, 46),]
  track_segment2 = [Point.new(-121, 45), Point.new(-121, 46),]
  track_segment3 = [Point.new(-121, 45.5), Point.new(-122, 45.5),]

  track1 = Track.new([track_segment1, track_segment2], "track 1")
  track2 = Track.new([track_segment3], "track 2")

  world = World.new("My Data", [waypoint1, waypoint2, track1, track2])

  puts world.to_geojson()
  
end

if File.identical?(__FILE__, $0)
  main()
end

