# frozen_string_literal: true

require_relative '../lib/unmustache/generate_regex'

describe Unmustache do
  describe '#generate_regex' do
    it 'generates a regex with {{ escaped_mustaches }}' do
      unmustache = described_class.new
      template_content = '{{ name }} {{ lastname }}'
      regex = unmustache.generate_regex(template_content)
      expect(regex).to be_a(Regexp)
      expect(regex).to eq(Regexp.new('(?<name>.*)\ (?<lastname>.*)'))
    end

    it 'generates a regex with {{{ unescaped_mustaches }}}' do
      unmustache = described_class.new
      template_content = '{{{ name }}} {{{ lastname }}}'
      regex = unmustache.generate_regex(template_content)
      expect(regex).to be_a(Regexp)
      expect(regex).to eq(Regexp.new('(?<name>.*)\ (?<lastname>.*)'))
    end
  end
end
