# frozen_string_literal: true

require_relative 'unmustache/version'
require_relative 'unmustache/generate_regex'

# TODO: Comments
module Unmustache
  class << self
    # Extracts the variables from rendered Mustache templates.
    # @param [String] template_file The Mustache template file (not the rendered template)
    # @param [String] template_contents The contents of the Mustache template (not the rendered template)
    # @param [String] rendered_template_file The RENDERED Mustache template file
    # @param [String] rendered_template_file The contents of the RENDERED Mustache template
    # @return [Hash] Key value pairs of the variables extracted from the rendered template
    def unmustache(
      template_file: nil,
      template_contents: nil,
      rendered_template_file: nil,
      rendered_template_contents: nil
    )
      template_contents = File.read(template_file) if template_contents.nil?
      regex = generate_regex(template_contents)

      # Extract the values from the rendered template
      rendered_template_contents = File.read(rendered_template_file) if rendered_template_contents.nil?
      matches = rendered_template_contents.match(regex).named_captures.transform_keys(&:to_sym)

      if matches.empty?
        raise ArgumentError,
              "The rendered template doesn't match the Mustache template."
      end

      matches
    end
  end
end
