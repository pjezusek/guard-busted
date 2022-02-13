# frozen_string_literal: true

require 'guard/plugin'
require 'guard/ui'

require_relative 'busted/options'
require_relative 'busted/runner'
require_relative 'busted/utils'

module Guard
  # Plugin for 'guard' which starts 'busted' (lua unit testing framework) if a change is detected.
  class Busted < Plugin
    include BustedUtils
    attr_reader :options, :runner

    # Initializes a Guard plugin.
    def initialize(options = {})
      super

      @options = Guard::BustedOptions::DEFAULTS.merge(options)
      @runner = Guard::BustedRunner.new(@options)
    end

    # Called once when Guard starts.
    def start
      check_if_busted_exist
      run_all if @options[:run_all_on_start]
    end

    # Called when just `enter` is pressed
    def run_all
      @runner.run_all
    end

    # Called on file(s) modifications that the Guard plugin watches.
    def run_on_modifications(paths)
      @runner.run(paths)
    end

    private

    def check_if_busted_exist
      return unless which('busted').nil?

      UI.error 'Busted not found. Use :cmd option or ' \
               'install `busted` via `luarocks install busted --local`'
    end
  end
end
