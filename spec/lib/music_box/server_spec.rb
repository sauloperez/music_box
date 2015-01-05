require 'spec_helper'

describe MusicBox::Server do
  let(:server) { double(Socket) }
  let(:connection) { double(Socket, close_write: true, close: true) }

  before {
    allow(TCPServer).to receive(:new).with(port).and_return(server)
  }

  describe '#start' do
    before {
      allow(Socket).to receive(:accept_loop).and_return(false)
    }
    after { subject.start }

    it 'gets the client connection as a block param' do
      expect(subject).to receive(:server_loop).and_yield(connection)
    end

    it 'plays the sent data' do
      expect(subject).to receive(:play).with(connection)
    end

    it 'binds to the address' do
      expect(server).to receive(:bind)
    end

    it 'listens as many as SOMAXCONN connections' do
      expect(server).to receive(:listen).with(Socket::SOMAXCONN)
    end

    it 'accepts connections' do
      expect(Socket).to receive(:accept_loop).with(server)
    end

    it 'handles the connection' do
      expect(subject).to receive(:handle).with(connection)
    end

    it 'closes the connection when done' do
      expect(connection).to receive(:close)
    end
  end

  describe '#play' do
    after { subject.play(argument) }
    let(:argument) { double(IO, read: data) }
    let(:data) { 'random content' }

    context 'when the argument is an IO object' do

      it 'reads from the provided IO object' do
        expect(argument).to receive(:read)
      end

      it 'sends the read data to the player process' do
        expect_any_instance_of(MusicBox::PlayerProcess)
          .to receive(:play).with(data)
      end
    end

    context 'when the argument is not an IO object' do
      it 'raises' do
        expect {
          subject.play('data')
        }.to raise_error { StandardError }
      end
    end
  end

  describe '#stop' do
    after { subject.stop }

    it 'sends a TERM signal to the player process' do
      expect_any_instance_of(MusicBox::PlayerProcess)
        .to receive(:kill).with('TERM')
    end
  end
end
