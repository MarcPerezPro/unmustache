# frozen_string_literal: true

require_relative "unmustache/version"

module Unmustache
    class << self
        attr_writer :logger
        def logger
            @logger ||= Logger.new($stdout).tap do |log|
                log.progname = self.name
            end
        end

        def unmustache(template_file, rendered_template)
            # Replace the mustache variables with regex capture groups
            template = File.read(template_file)
            values = template.scan(/{{\s*(.*?)\s*}}/)
            if values.empty?
                logger.warn "No mustache variables found in #{template_file}, are you sure this is a mustache template?"
                return {}
            end
            escaped_template = Regexp.escape(template) # In case the template contains regex characters
            values.each do |value|
                escaped_template.gsub!(/\\{\\{(\\\s)*#{value[0]}(\\\s)*\\}\\}/, "(?<#{value[0]}>.*?)")
            end
            regex = Regexp.new(escaped_template)
            puts regex.to_s.sub!("(?-mix:", "").chomp(')')
            if template.scan(regex).flatten.empty? # Assert that the regex matches itself
                raise RegexpError.new("Error while contructing the unmustache Regex")
            end

            # Extract the values from the rendered template
            rendered = File.read(rendered_template)
            matches = rendered.scan(regex).flatten
            if matches.empty?
                raise ArgumentError.new("The rendered template #{rendered_template} doesn't match the Mustache template #{template_file}")
            end
            # TODO: Check for duplicate keys that have different values
            return matches
        end
    end
end
