require 'socket'
server = TCPServer.new 5678

while session = server.accept
  session.puts "I am your Ruby server! The time is #{Time.now.strftime("%I:%M:%S %p")}"
  session.close
end
