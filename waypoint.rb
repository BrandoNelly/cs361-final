class Waypoint

attr_reader :lat, :lon, :elevation, :name, :type

  def initialize(lon, lat, elevation=nil, name=nil, type=nil)
	
    @lat = lat
    @lon = lon
    @elevation = elevation
    @name = name
    @type = type
  end

  def get_json_feature(indent=0)
    j = '{"type": "Feature",'
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
      if type != nil 
        if name != nil
          j += ','
        end
        j += '"icon": "' + @type + '"' 
      end
      j += '}'
    end
    j += "}"
    return j
  end
end