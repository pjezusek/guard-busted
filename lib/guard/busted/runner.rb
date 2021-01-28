# frozen_string_literal: true

module Guard
  # The class responsible for running 'busted' command in the proper context.
  class BustedRunner < Plugin
    attr_accessor :options, :cmd, :cmd_options, :cmd_all, :cmd_all_options

    def initialize(options)
      super

      @cmd = options[:cmd]
      @cmd_options = options[:cmd_options]
      @cmd_all = options[:cmd_all]
      @cmd_all_options = options[:cmd_all_options]
    end

    # Run all tests in the project
    #
    # @raise [:task_has_failed] when run_all has failed
    def run_all
      puts 'Running all tests'
      status = system(command_all)
      throw(:task_has_failed) unless status
    end

    def run(paths)
      puts "Running #{paths.join(', ')}"
      results = paths.map do |path|
        if Pathname.new(path).exist?
          system([command, path].join(' '))
        else
          true
        end
      end
      throw(:task_has_failed) if results.any? { |x| x == false }
    end

    private

    def command
      [options[:cmd], *options[:cmd_options]].join(' ')
    end

    def command_all
      [options[:cmd_all], *options[:cmd_all_options]].join(' ')
    end
  end
end
