# frozen_string_literal: true

require_relative 'unmustache/version'
require_relative 'unmustache/generate_regex'

# TODO: Comments
module Unmustache
  class << self
    def unmustache(
                  template_file: nil,
                  template_contents: nil,
                  rendered_template_file: nil,
                  rendered_template_contents: nil)
      if template_contents.nil?
        template_contents = File.read(template_file)
      end
      regex = generate_regex(template_contents)

      # Extract the values from the rendered template
      if rendered_template_contents.nil?
        rendered_template_contents = File.read(rendered_template_file)
      end
      matches = rendered_template_contents.match(regex).named_captures

      if matches.empty?
        raise ArgumentError,
              "The rendered template doesn't match the Mustache template."
      end

      matches
    end
  end
end
