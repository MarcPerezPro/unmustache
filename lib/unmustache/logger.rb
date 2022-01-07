# frozen_string_literal: true

class Unmustache
  attr_writer :logger

  def logger
    @logger ||= Logger.new($stdout).tap do |log|
      log.progname = name
    end
  end
end
