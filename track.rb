class TrackSegment 
  attr_reader :coordinates
  def initialize(coordinates)
    @coordinates = coordinates
  end
end

class Track < TrackSegment
   def initialize(segments, name = nil)
    @name = name
    @segments = segments.map { |segment| TrackSegment.new(segment) }
  end

  def get_json_feature()
    json = '{'
    json += '"type": "Feature", '
    if @name != nil
      json+= '"properties": {'
      json += '"title": "' + @name + '"'
      json += '},'
    end
    json += '"geometry": {'
    json += '"type": "MultiLineString",'
    json +='"coordinates": ['
    @segments.each_with_index do |segment, index|
      if index > 0
        json += ","
      end
      json += '['
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
      json+=tsj
      json+=']'
    end
    json + ']}}'
  end
end

