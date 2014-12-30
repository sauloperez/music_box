require 'open3'

class StreamPlayer
  def initialize(file)
    @file = file
  end

  def play
    spawn_player do |stdin, stdout, stderr|
      @stdin = stdin

      basename = File.basename(@file.path)
      puts "Playing #{basename}..."

      begin
        stdin.puts @file.read
      rescue IOError => e
        raise e unless e.message == 'closed stream'
      end
    end
  end

  def stop
    @stdin.close
    puts 'Bye'
  end

  private

  def spawn_player
    Open3.popen3('mpg123', '-') do |stdin, stdout, stderr|
      yield stdin, stdout, stderr
    end
  end
end

