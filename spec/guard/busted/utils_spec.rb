# frozen_string_literal: true

module RspecDummy
  class DummyBustedUtils
    include Guard::BustedUtils
  end
end

RSpec.describe Guard::BustedUtils do
  let(:instance) { RspecDummy::DummyBustedUtils.new }

  describe '#which' do
    context 'with an existing executable' do
      it 'finds path to the exe' do
        root_path = `git rev-parse --show-toplevel 2>/dev/null`.strip
        ENV['PATH'] = "#{root_path}/spec/fixtures/"
        expect(Pathname.new(instance.which('executable')).exist?).to be true
      end
    end

    context 'without existing executable' do
      it 'returns nil' do
        expect(instance.which('some_not_existing_entry')).to be nil
      end
    end
  end
end
