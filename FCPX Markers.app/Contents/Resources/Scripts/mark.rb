require "rexml/document"
include REXML

# Compressor error constant for importing markers. Offset/second
COMPRESSOR_ERROR = 0.001

if !ARGV[0] || !File.exists?(ARGV[0])
  puts "error opening file: #{ARGV[0]}"
  exit 1
end

doc = ( Document.new File.new ARGV[0] ).root

def parseTime(duration)
  if(duration.nil? or !duration.to_s.include? '/')
      return 0
  end

  duration = duration.to_s.sub( "s", "" )
  duration = duration.split('/')
  return duration[0].to_f / duration[1].to_f
end

def calulateOffset(element)

  start = parseTime(element.attribute("start"))

  offset = parseTime(element.attribute("offset"))

  return start - offset
end

framerate = parseTime(doc.elements["project/resources/format"].attribute("frameDuration"))

doc.elements.to_a("//marker").each_with_index do |marker, i| 

  uncompensatedTotal = parseTime(marker.attribute("start")) - calulateOffset(marker.parent)

  total = uncompensatedTotal - ( uncompensatedTotal * COMPRESSOR_ERROR )
  
  timecode = []
  timecode.push '%02d' % (total / 60 / 60 % 60).floor
  timecode.push '%02d' % (total / 60 % 60).floor
  timecode.push '%02d' % (total % 60).floor
  timecode.push '%02d' % (total % 1 / framerate).floor

  puts  timecode.join(":") + " " + marker.attribute('value').to_s
end