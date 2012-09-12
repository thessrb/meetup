require 'matrix'
require 'cmath'
filename=ARGV.shift
input=File.readlines(filename)

def b day
  2*Math::PI*(day-81)/364.0
end

def e b_value
  9.87*CMath.sin(2*b_value)-7.53*CMath.cos(b_value)-1.5*CMath.sin(b_value)
end

def dt e_value,lat_st_deg=30,lat_f_deg=42
  (4*lat_st_deg-lat_f_deg+e_value).to_i
end

def solar_time minutes,dt
  return minutes+dt if minutes+dt < 1440
  minutes+dt - 1440
end

def delta day
  23.45*2*Math::PI/360*CMath.sin((2*Math::PI/365)*(284+day))
end

def omega solar_time_val
  (2*Math::PI/360)*(solar_time_val-720)/60*15
end

def watt delta_val,omega_val,slope_rad,rotation_rad,lat_f=2*Math::PI*42/360.0
  CMath.sin(delta_val) * CMath.sin(lat_f) * CMath.cos(slope_rad)-CMath.sin(delta_val) * CMath.cos(lat_f) * CMath.sin(slope_rad) * CMath.cos(rotation_rad)+	CMath.cos(delta_val) * CMath.cos(lat_f) * CMath.cos(slope_rad) * CMath.cos(omega_val)	+	CMath.cos(delta_val) * CMath.sin(lat_f) * CMath.sin(slope_rad) * CMath.cos(rotation_rad) * CMath.cos(omega_val)+CMath.cos(delta_val) * CMath.sin(slope_rad) * CMath.sin(rotation_rad) * CMath.sin(omega_val)
end

start=Time.now
matrix=input.map do |line|
  values=line.split(',')
  values.map!{|el| el.strip.to_f }
  b_val=b(values[0])
  e_val=e(b_val)
  dt_val=dt(e_val)
  solar_time_val=solar_time(values[3],dt_val)
  values+[b_val,e_val,dt_val,solar_time_val,delta(values[0]),omega(solar_time_val)]
end
p matrix
threads=[]
(0..90).step(5) do |slope|
  threads<<Thread.new do 
    slope_rad=2*Math::PI*slope/360
    (-90..90).step(5) do |rotation|
      rotation_rad=2*Math::PI*rotation/360
      matrix.each do |m|
         p watt(m[8],m[9],slope_rad,rotation_rad)
      end
    end
  end
end
threads.each{|t| t.join}
p Time.now-start