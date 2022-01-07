# frozen_string_literal: true

require 'mustache'

class ConfigScript < Mustache
  # @param [Hash] options the variables to inject in the template
  # @option options [String] :firstname The firstname of the user
  # @option options [String] :lastname The lastname of the user
  def initialize(**options)
    super()
    self.template_file = File.join(File.dirname(__FILE__), 'config_script_v2.sh.mustache')

    options.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  attr_accessor(:firstname, :lastname)
end
