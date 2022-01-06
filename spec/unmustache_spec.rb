require 'unmustache'

describe Unmustache do
  describe '#unmustache' do
    it 'extracts the variables from a rendered Mustache template' do
      template_contents = '{{ name }} {{ lastname }}'
      rendered_template_contents = 'John Doe'
      variables = Unmustache.unmustache(template_contents: template_contents, rendered_template_contents: rendered_template_contents)
      expect(variables).to be_a(Hash)
      expect(variables).to eq({ 'name' => 'John', 'lastname' => 'Doe' })
    end
  end
end
