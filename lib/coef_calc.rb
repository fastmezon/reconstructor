require 'ffi-geos'

module CoefCalc

  @@wkt_reader = Geos::WktReader.new

  def self.gen_pixel(xb,yb,l)
    xt = xb+l
    yt = yb+l

    coordinates = [
      [xb, yb],
      [xt, yb],
      [xt, yt],
      [xb, yt],
      [xb, yb]
    ]

    coordinates_string = coordinates.map { |c| c.join(' ') }.join(', ')
    wkt_string = "POLYGON((#{coordinates_string}))"

    @@wkt_reader.read(wkt_string)
  end

  def self.gen_scope(xt,xb,h,f)
    yb = h
    yt = -h

    coordinates = [
      [xb, yb],
      [xt, yb],
      [xt, yt],
      [xb, yt],
      [xb, yb]
    ]



   rotated_coordinates = coordinates.map { |pt| [Utils.x_rotate(pt[0],pt[1],f), Utils.y_rotate(pt[0],pt[1],f)] }
    coordinates_string = rotated_coordinates.map { |c| c.join(' ') }.join(', ')

    wkt_string = "POLYGON((#{coordinates_string}))"

    @@wkt_reader.read(wkt_string)

  end

  def self.calc(xb,yb,s_xt,s_xb,h,f)
    pixel = gen_pixel(xb,yb,1)
    scope = gen_scope(s_xt,s_xb,h,f)
    pixel.intersection(scope).area
  end

end

module  Utils
  def self.x_rotate(x0,y0,f)
    x0*Math.cos(f) - y0*Math.sin(f)
  end

  def self.y_rotate(x0,y0,f)
    x0*Math.sin(f) + y0*Math.cos(f)
  end
end
