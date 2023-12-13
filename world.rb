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


=begin
class FeatureJson
		def get_json
	end

	class TrackJson < FeatureJson

		
		def get_json
			if feature.class == Track
				segment += feature.get_track_json
			end
		end
	end


	class WaypointJson < FeatureJson
		
		def get_json
			if feature.class == Waypoint
				segment += feature.get_waypoint_json
			end
		end
	end
=end