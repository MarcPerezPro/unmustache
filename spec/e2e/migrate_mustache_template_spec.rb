# frozen_string_literal: true

require 'mustache'
require 'unmustache'
require_relative './config_script'

describe Unmustache do
  describe 'E2E' do
    it 'migrates an old config file to a new format' do
      # Get the variables from the old config file
      config_v1_variables = described_class.unmustache(
        template_file: File.join(File.dirname(__FILE__), 'config_script_v1.sh.mustache'),
        rendered_template_file: File.join(File.dirname(__FILE__), 'input', 'generated_config_script_v1.sh')
      )
      expect(config_v1_variables).to be_a(Hash)
      expect(config_v1_variables).to eq({ firstname: 'Mark' })

      # Create a new config file with the new format
      config_script_v2 = ConfigScript.new(config_v1_variables)
      # Add the new variables from the updated config file Mustache template
      config_script_v2[:lastname] = 'PEREZ'
      # Render the new config file
      rendered_config_script_v2_contents = config_script_v2.render

      # Test that the new config file is valid
      expected_rendered_config_script_v2_contents = File.read(File.join(File.dirname(__FILE__), 'output',
                                                                        'generated_config_script_v2.sh'))
      expect(rendered_config_script_v2_contents).to eq(expected_rendered_config_script_v2_contents)
    end
  end
end
