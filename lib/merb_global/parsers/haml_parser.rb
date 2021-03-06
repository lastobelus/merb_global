# Haml gettext parser module
#
# http://pastie.org/445297
require 'gettext/tools/rgettext'
require 'gettext/parser/ruby'
require 'haml'

class Haml::Engine
  # Overriden function that parses Haml tags
  # Injects gettext call for plain text action.
  def parse_tag(line)
    tag_name, attributes, attributes_hash, object_ref, nuke_outer_whitespace,
      nuke_inner_whitespace, action, value = super(line)
    @precompiled << "_(\"#{value}\")\n" unless action || value.empty?
    [tag_name, attributes, attributes_hash, object_ref, nuke_outer_whitespace,
        nuke_inner_whitespace, action, value]
  end
  # Overriden function that producted Haml plain text
  # Injects gettext call for plain text action.
  def push_plain(text)
    @precompiled << "_(\"#{text.strip}\")\n"
  end

  def push_script(text, opts={})
    @precompiled << "#{text}\n"
  end
end

# Haml gettext parser
module HamlParser
  module_function

  def target?(file)
    File.extname(file) == ".haml"
  end

  def parse(file, ary = [])
    haml = Haml::Engine.new(IO.readlines(file).join)
    code = haml.precompiled.split(/$/)
    puts "code: #{code.inspect}"
    GetText::RubyParser.parse_lines(file, code, ary)
  end
end

module Haml
  module Filters
    module Localize
      include Haml::Filters::Base
      include Merb::Global
      def render(text); text; end
      def compile(precompiler, text)
        resolve_lazy_requires
        filter = self
        precompiler.instance_eval do
          push_plain(text.strip)
        end
      end
    end
  end
end

GetText::RGetText.add_parser(HamlParser)
