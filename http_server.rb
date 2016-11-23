require 'socket'
require 'rack'
require 'rack/lobster'

app = Rack::Lobster.new

server = TCPServer.new 5678

while session = server.accept
  request = session.gets
  puts request

  # 1
  status, headers, body = app.call({})
  # 2
  session.print "HTTP/1.1 #{status}\r\n"
  # 3
  headers.each do |key, value|
    session.print "#{key}: #{value}\r\n"
  end
  # 4
  session.print "\r\n"
  # 5
  body.each do |part|
    session.print part
  end

  session.close

  # session.print "HTTP/1.1 200\r\n" # 1 status line
  # session.print "Content-Type: text/html\r\n" # 2 header
  # session.print "\r\n" # 3 newline
  # session.print "Hi there! I am your Ruby server! The time is
  #   #{Time.now.strftime("%I:%M:%S %p")}" #4 body

  # session.close
end
