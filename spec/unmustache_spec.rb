# frozen_string_literal: true

require 'unmustache'

describe Unmustache do
  describe '#unmustache' do
    it 'extracts escaped variables from a rendered Mustache template' do # rubocop:disable RSpec/ExampleLength
      unmustache = described_class.new
      template_contents = '{{first_number}} {{sign}} {{second_number}}'
      rendered_template_contents = '5 &gt; 2'
      variables = unmustache.unmustache(template_contents: template_contents,
                                        rendered_template_contents: rendered_template_contents)
      expect(variables).to be_a(Hash)
      expect(variables).to eq({ first_number: '5', sign: '>', second_number: '2' })
    end

    it 'extracts unescaped variables from a rendered Mustache template' do # rubocop:disable RSpec/ExampleLength
      unmustache = described_class.new
      template_contents = '{{{first_number}}} {{{sign}}} {{{second_number}}}'
      rendered_template_contents = '5 > 2'
      variables = unmustache.unmustache(template_contents: template_contents,
                                        rendered_template_contents: rendered_template_contents)
      expect(variables).to be_a(Hash)
      expect(variables).to eq({ first_number: '5', sign: '>', second_number: '2' })
    end
  end
end
