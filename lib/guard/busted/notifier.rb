# frozen_string_literal: true

require 'guard/notifier'

module Guard
  # Wrapper for Guard::Notifier to make system notifications
  class BustedNotifier
    attr_accessor :raw_message, :status

    FAILURE_TITLE = 'Busted - Failure'
    SUCCESS_TITLE = 'Busted - Success'

    # Initialize BustedNotifier
    #
    # @param message [String] message to parse, output from busted command
    # @param status [Boolean] status of busted command
    def initialize(message, status)
      @raw_message = message
      @status = status
    end

    # Send notification to the system
    #
    # The type of the notification depends on the status of busted command.
    def notify
      if status
        notify_success
      else
        notify_failure
      end
    end

    private

    # Parse +raw_message+ to extract summary for a notification
    # For now it only supports utfTerminal output
    #
    # @return [String]
    def summary
      @raw_message.match(/^.*success.*$/)
                  .to_s
                  .gsub(/[[:cntrl:]]/, '')
                  .gsub(/\[[0-9]+m/, '')
                  .gsub(/ : [0-9]+\.[0-9]+ seconds/, '')
    end

    # Notify with failure
    def notify_failure
      Guard::Notifier.notify(
        summary,
        title: FAILURE_TITLE,
        image: :failed,
        priority: 2
      )
    end

    # Notify with success
    def notify_success
      Guard::Notifier.notify(
        summary,
        title: SUCCESS_TITLE,
        image: :success,
        priority: -2
      )
    end
  end
end
