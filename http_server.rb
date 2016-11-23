require 'socket'
require 'rack'
require 'rack/lobster'

app = Rack::Lobster.new

server = TCPServer.new 5678

while session = server.accept
  request = session.gets
  puts request
  # split the request string into a method and a full path
  method, full_path = request.split(' ')
  # split the full path into a path and a query
  path, query = full_path.split('?')
  # pass those to our app in a Rack environment hash
  status, headers, body = app.call({
    'REQUEST_METHOD' => method,
    'PATH_INFO' => path,
    'QUERY_STRING' => query
  })

  session.print "HTTP/1.1 #{status}\r\n"

  headers.each do |key, value|
    session.print "#{key}: #{value}\r\n"
  end

  session.print "\r\n"

  body.each do |part|
    session.print part
  end

  session.close
end
