require 'socket'
server = TCPServer.new 5678

while session = server.accept
  request = session.gets
  puts request

  session.print "HTTP/1.1 200\r\n" # 1 status line
  session.print "Content-Type: text/html\r\n" # 2 header
  session.print "\r\n" # 3 newline
  session.print "Hi there! I am your Ruby server! The time is
    #{Time.now.strftime("%I:%M:%S %p")}" #4 body

  session.close
end
