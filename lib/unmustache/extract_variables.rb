# frozen_string_literal: true

require 'cgi'

class Unmustache
  @extracted_variables

  # Extract the variables from the rendered template
  # @param [String] rendered_template_contents The contents of the RENDERED Mustache template
  # @return [Hash] Key value pairs of the variables extracted from the rendered template
  def extract_variables(rendered_template_contents)
    # Extract the variables from the rendered template
    matches = rendered_template_contents.match(@regex)
    named_captures = matches.named_captures
    @extracted_variables = named_captures.transform_keys(&:to_sym)

    # Unescape the variables that used {{ double_mustaches }}
    @escaped_variables.each do |value|
      @extracted_variables[value[0].to_sym] = CGI.unescapeHTML(@extracted_variables[value[0].to_sym])
    end

    @extracted_variables
  end
end
