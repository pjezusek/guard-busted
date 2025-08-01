# frozen_string_literal: true

RSpec.describe Guard::Busted do
  before do
    Guard::Plugin.class_eval do
      def initialize(options = {}); end
    end
  end

  it 'has a version number' do
    expect(Guard::BustedVersion::VERSION).not_to be_nil
  end

  it 'allows to overrite options on #new' do
    object = described_class.new(foo: :bar)
    expect(object.options[:foo]).to eq :bar
  end

  it 'initializes runner on #new' do
    object = described_class.new(foo: :bar)
    expect(object.runner.is_a?(Guard::BustedRunner)).to be true
  end

  describe '#start' do
    context 'when :run_all_on_start option is set to false' do
      let(:object) { described_class.new(run_all_on_start: false) }

      it 'does not run all tests' do
        allow(object.runner).to receive(:run_all)
        object.start
        expect(object.runner).not_to have_received(:run_all)
      end
    end

    context 'when busted exist' do
      let(:object) { described_class.new(run_all_on_start: true) }

      it 'runs all tests' do
        allow(object.runner).to receive(:run_all)
        object.start
        expect(object.runner).to have_received(:run_all)
      end
    end

    context 'when busted does not exist' do
      let(:object) { described_class.new(run_all_on_start: true) }

      it 'runs all tests' do
        allow(object.runner).to receive(:run_all)
        object.start
        expect(object.runner).to have_received(:run_all)
      end

      it 'prints error about missing busted' do
        allow(Guard::UI).to receive(:error)
        allow(object.runner).to receive(:run_all)
        allow(object).to receive(:which).and_return(nil)
        object.start
        expect(Guard::UI).to have_received(:error)
      end
    end
  end

  describe '#run_all' do
    let(:object) { described_class.new(run_all_on_start: true) }

    it 'runs all tests' do
      allow(object.runner).to receive(:run_all)
      object.run_all
      expect(object.runner).to have_received(:run_all)
    end
  end

  describe '#run_on_modifications' do
    let(:object) { described_class.new }

    it 'runs all tests' do
      allow(object.runner).to receive(:run)
      object.run_on_modifications(%i[foo bar])
      expect(object.runner).to have_received(:run).with(%i[foo bar])
    end
  end
end
