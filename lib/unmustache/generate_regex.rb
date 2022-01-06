# frozen_string_literal: true

require_relative 'logger'

module Unmustache
  class << self
    # Generates a Regular Expression that can be used to extract the variables from a rendered Mustache template
    # @param [String] template_content The contents of the Mustache template (not the rendered template)
    # @return [Regexp]
    def generate_regex(template_content)
      # Replace the mustache variables with regex capture groups
      values = template_content.scan(/{{\s*(.*?)\s*}}/)
      if values.empty?
        logger.warn 'No mustache variables found in the template contents, are you sure this is a mustache template?'
        return {}
      end
      escaped_template = Regexp.escape(template_content) # In case the template contains regex characters
      values.each do |value|
        escaped_template.gsub!(/\\{\\{(\\\s)*#{value[0]}(\\\s)*\\}\\}/, "(?<#{value[0]}>.*)")
      end
      regex = Regexp.new(escaped_template)
      # puts regex.to_s.sub('(?-mix:', '').chomp(')')
      if template_content.scan(regex).flatten.empty? # Assert that the regex matches itself
        raise RegexpError, 'Error while contructing the unmustache Regex'
      end

      regex
    end
  end
end
