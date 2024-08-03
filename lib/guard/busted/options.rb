# frozen_string_literal: true

module Guard
  module BustedOptions
    DEFAULTS = {
      run_all_on_start: false,
      cmd: 'busted',
      cmd_options: ['-o', 'utfTerminal', '--Xoutput', '--color'],
      cmd_all: 'busted',
      cmd_all_options: ['-o', 'utfTerminal', '--Xoutput', '--color']
    }.freeze
  end
end
