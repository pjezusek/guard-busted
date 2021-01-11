# frozen_string_literal: true

require 'guard/compat/plugin'

require 'guard/busted/options'
require 'guard/busted/runner'
require 'guard/busted/utils'

module Guard
  # Plugin for 'guard' which starts 'busted' (lua unit testing framework) if change is dtected.
  class Busted < Plugin
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
      return if Guard::BustedUtils.which('busted').nil?

      Compat::UI.warning(
        'Busted not found. Use :cmd option or ' \
        'install `busted` via `luarocks install busted --local`'
      )
    end
  end
end
