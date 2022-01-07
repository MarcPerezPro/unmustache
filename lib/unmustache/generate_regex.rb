# frozen_string_literal: true

require_relative 'logger'

class Unmustache # rubocop:disable Style/Documentation
  private

  attr_accessor(:regex, :escaped_variables, :unescaped_variables)

  def scan_escaped_variables(template_contents)
    # Look for {{ escaped_variable }}
    template_contents.scan(/\{{2}\s*([A-Za-z_][A-Za-z0-9_]*)\s*\}{2}/)
  end

  def scan_unescaped_variables(template_contents)
    # Look for {{{ unescaped_variable }}}
    template_contents.scan(/\{{3}\s*([A-Za-z_][A-Za-z0-9_]*)\s*\}{3}/)
  end

  def replace_mustaches_with_regex_capture_groups(escaped_template)
    variables = @escaped_variables + @unescaped_variables
    variables.each do |value|
      # The template is escaped so the regex is more complex
      # It looks for \{\{\ escaped_variable\ \}\} or \{\{\{\ unescaped_variable\ \}\}\}
      # Then changes it to a named capture group
      escaped_template.gsub!(/(\\\{){2,3}(\\\s)*#{value[0]}(\\\s)*(\\\}){2,3}/, "(?<#{value[0]}>.*)")
    end
    escaped_template
  end

  # Generates a Regular Expression that can be used to extract the variables from a rendered Mustache template
  # @param [String] template_contents The contents of the Mustache template (not the rendered template)
  # @return [Regexp]
  def generate_regex(template_contents) # rubocop:disable Metrics/MethodLength
    # Find the {mustache} variables
    @escaped_variables = scan_escaped_variables(template_contents)
    @unescaped_variables = scan_unescaped_variables(template_contents)
    if @escaped_variables.empty? && @unescaped_variables.empty?
      logger.warn 'No mustache variables found in the template contents, are you sure this is a mustache template?'
      return /a^/ # Matches nothing
    end

    # Replace escaped {mustache} variables with regex capture groups
    escaped_template = Regexp.escape(template_contents) # In case the template contains regex characters
    escaped_template = replace_mustaches_with_regex_capture_groups(escaped_template)
    regex = Regexp.new(escaped_template)
    # puts regex.to_s.sub('(?-mix:', '').chomp(')')
    if template_contents.scan(regex).flatten.empty? # Assert that the regex matches itself
      raise RegexpError, 'Error while contructing the unmustache Regex'
    end

    @regex = regex
    regex
  end
end
