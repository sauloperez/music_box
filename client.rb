require 'socket'

filename = ARGV[0]
file = File.open(filename)

socket = Socket.new(:INET, :STREAM)
remote_addr = Socket.pack_sockaddr_in(4481, '127.0.0.1')
socket.connect(remote_addr)

puts 'Sending data...'
socket.puts file.read

