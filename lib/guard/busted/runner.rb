# frozen_string_literal: true

require 'guard/ui'

require_relative 'notifier'

module Guard
  # The class responsible for running 'busted' command in the proper context.
  class BustedRunner < Plugin
    attr_accessor :cmd, :cmd_options, :cmd_all, :cmd_all_options

    # Initialize BustedRunner
    # It accepts following options:
    #   - cmd - command to perform for specific spec files,
    #   - cmd_options [Array<String>] - options for cmd command,
    #   - cmd_all - command to perform for all spec files
    #   - cmd_all_options [Array<String>] - options for cmd_all command.
    #
    # @param options [Hash<Symbol, String>] options for runner
    def initialize(options)
      super

      @cmd = options[:cmd]
      @cmd_options = Array(options[:cmd_options])
      @cmd_all = options[:cmd_all]
      @cmd_all_options = Array(options[:cmd_all_options])
    end

    # Run all tests in the project
    #
    # @raise [:task_has_failed] when run_all has failed
    def run_all
      UI.info 'Running all tests'
      status, stdout = perform_command([@cmd_all] + @cmd_all_options)
      Guard::BustedNotifier.new(stdout, status).notify
      throw(:task_has_failed) unless status
    end

    # Run tests for the given paths
    #
    # @param paths [Array<String>] array of spec files
    #
    # @raise [:task_has_failed] when tests failed
    def run(paths)
      existing_paths = paths.select { |p| Pathname.new(p).exist? }
      UI.info "Running #{existing_paths.join(', ')}"
      status, stdout = perform_command([@cmd] + @cmd_options + existing_paths)
      Guard::BustedNotifier.new(stdout, status).notify
      throw(:task_has_failed) unless status
    end

    private

    # Performs command and print stdout and stderr to the console
    #
    # @param cmd [String] command to perform
    #
    # @return [Array<Boolean, String>]
    def perform_command(cmd)
      message = ''
      status = 0
      Open3.popen2e(*cmd) do |_, stdout_and_stderr, wait_thr|
        while (line = stdout_and_stderr.gets)
          message += line
          puts line
        end
        status = wait_thr.value.success?
      end

      [status, message]
    end
  end
end
