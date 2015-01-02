require 'spec_helper'

describe MusicBox::Runner do
  let(:server) {
    double(MusicBox::StreamPlayerServer,
           start: true,
           stop: true)
  }
  before {
    allow(MusicBox::StreamPlayerServer).to receive(:new).and_return(server)
  }


  describe '#start' do
    it 'starts the StreamPlayer server' do
      expect(server).to receive(:start)
      MusicBox::Runner.start
    end

    it 'sets INT signal trap' do
      expect_any_instance_of(MusicBox::Runner).to receive(:trap).with('INT')
      MusicBox::Runner.start
    end
  end

  describe '#shutdown' do
    it 'stops the server when INT signal is received' do
      allow(subject).to receive(:exit)
      expect(server).to receive(:stop)
      subject.shutdown
    end

    it 'finishes the app' do
      expect(subject).to receive(:exit)
      subject.shutdown
    end
  end
end
