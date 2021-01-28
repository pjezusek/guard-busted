# frozen_string_literal: true

require 'guard/compat/test/helper'

RSpec.describe Guard::BustedRunner do
  let(:options) do
    {
      cmd: 'some_command',
      cmd_options: 'some_options',
      cmd_all: 'some_command_all',
      cmd_all_options: 'some_command_all_options'
    }
  end
  let(:instance) { Guard::BustedRunner.new(options) }

  describe '.new' do
    it 'extracts data from options' do
      expect(
        [instance.cmd, instance.cmd_options, instance.cmd_all, instance.cmd_all_options]
      ).to eq(
        %w[some_command some_options some_command_all some_command_all_options]
      )
    end
  end

  describe '#run_all' do
    context 'when the system command ends with an error' do
      before do
        allow(instance).to receive(:system).and_return(false)
      end

      it 'should throw :task_has_failed' do
        expect { instance.run_all }.to raise_error
      end
    end

    context 'when the system command ends successfully' do
      before do
        allow(instance).to receive(:system).and_return(true)
      end

      it 'runs a command for all tests' do
        instance.run_all
        expect(instance).to have_received(:system).with(
          'some_command_all some_command_all_options'
        )
      end
    end
  end

  describe '#run' do
    context 'when the system command ends with an error' do
      before do
        allow(instance).to receive(:system).and_return(false)
      end

      it 'runs a test command for the given paths' do
        expect { instance.run['path'] }.to raise_error
      end
    end

    context 'when the system command ends successfully' do
      before do
        allow(instance).to receive(:system).and_return(true)
      end

      it 'runs a test command for the given paths' do
        root_path = `git rev-parse --show-toplevel 2>/dev/null`.strip
        file = "#{root_path}/spec/fixtures/some_file"
        instance.run([file])
        expect(instance).to have_received(:system).with(
          "some_command some_options #{file}"
        )
      end
    end
  end
end
