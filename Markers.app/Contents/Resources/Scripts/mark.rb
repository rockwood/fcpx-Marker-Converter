require "rexml/document"

include REXML

if !ARGV[0] || !File.exists?(ARGV[0])
  puts "error opening file: #{ARGV[0]}"
  exit 1
end

file = File.new( ARGV[0] )
doc = Document.new file

def parse(duration)
  duration = duration.to_s.sub( "s", "" )
  duration = duration.split('/')
  return duration[0].to_f / duration[1].to_f
end

framerate = parse(doc.root.elements["project/resources/format"].attribute("frameDuration"))

doc.root.elements.each("project/sequence/spine/clip/marker") { |marker| 
  
  total = parse marker.attribute("start")
  
  timecode = []
  timecode.push '%02d' % (total / 60 / 60 % 60).floor
  timecode.push '%02d' % (total / 60 % 60).floor
  timecode.push '%02d' % (total % 60).floor
  timecode.push '%02d' % (total % 1 / framerate).floor

  puts  "#{timecode.join(":")} #{marker.attribute('value')}"
}