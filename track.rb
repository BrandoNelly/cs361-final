require_relative 'track_segment'


class Track
   def initialize(segments, name = nil)
    @name = name
    @segments = segments.map { |segment| TrackSegment.new(segment) }
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

