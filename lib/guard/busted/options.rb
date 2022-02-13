# frozen_string_literal: true

module Guard
  module BustedOptions
    DEFAULTS = {
      run_all_on_start: false,
      cmd: 'busted -o utfTerminal',
      cmd_options: [],
      cmd_all: 'busted -o utfTerminal',
      cmd_all_options: []
    }.freeze
  end
end
