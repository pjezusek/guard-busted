# frozen_string_literal: true

require 'guard/compat/test/helper'

RSpec.describe Guard::BustedRunner do
  before do
    # disable notification from busted
    allow_any_instance_of(Guard::BustedNotifier).to receive(:notify).and_return(true)
  end

  let(:runner) do
    options = {
      cmd: 'some_command',
      cmd_options: ['--some_option_1', 'some_value_1', '--some_option_2'],
      cmd_all: 'some_command_all',
      cmd_all_options: ['--some_all_option_1', 'some_value_1', '--some_all_option_2']
    }
    Guard::BustedRunner.new(options)
  end

  describe '.new' do
    it 'extracts data from options' do
      expect(
        [runner.cmd, runner.cmd_options, runner.cmd_all, runner.cmd_all_options]
      ).to eq(
        [
          'some_command',
          ['--some_option_1', 'some_value_1', '--some_option_2'],
          'some_command_all',
          ['--some_all_option_1', 'some_value_1', '--some_all_option_2']
        ]
      )
    end
  end

  describe '#run_all' do
    context 'when the system command ends with an error' do
      before do
        allow(runner).to receive(:perform_command).and_return([false, 'some_message'])
      end

      it 'should throw :task_has_failed' do
        expect { runner.run_all }.to raise_error
      end
    end

    context 'when the system command ends successfully' do
      before do
        allow(Open3).to receive(:popen2e)
      end

      it 'runs a command for all tests' do
        runner.run_all
        expect(Open3).to have_received(:popen2e).with(
          'some_command_all', '--some_all_option_1', 'some_value_1', '--some_all_option_2'
        )
      end
    end
  end

  describe '#run' do
    context 'when the system command ends with an error' do
      before do
        allow(runner).to receive(:perform_command).and_return([false, 'some_message'])
      end

      it 'runs a test command for the given paths' do
        expect { runner.run ['path'] }.to raise_error
      end
    end

    context 'when the system command ends successfully' do
      let(:file_path) { 'spec/fixtures/some_file' }

      before do
        allow(Open3).to receive(:popen2e)
      end

      it 'runs a test command for the given paths' do
        runner.run [file_path, file_path]
        expect(Open3).to have_received(:popen2e).with(
          'some_command', '--some_option_1', 'some_value_1', '--some_option_2', file_path, file_path
        )
      end
    end
  end
end
