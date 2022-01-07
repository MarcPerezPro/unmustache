# frozen_string_literal: true

class Unmustache # rubocop:disable Style/Documentation
  attr_writer :logger

  private

  def logger
    @logger ||= Logger.new($stdout).tap do |log|
      log.progname = name
    end
  end
end
