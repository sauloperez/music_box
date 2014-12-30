require 'open3'

class StreamPlayer
  def initialize(file)
    @file = file
  end

  def play
    spawn_player

    basename = File.basename(@file.path)
    puts "Playing #{basename}..."

    @stdin.puts @file.read
  rescue Errno::EPIPE
  end

  def stop
    Process.kill('TERM', @pid)
    puts 'Bye'
  end

  private

  def spawn_player
    @stdin, @stdout, @stderr, @wait_thread = Open3.popen3('mpg123', '-')
    @pid = @wait_thread[:pid]
  end
end

