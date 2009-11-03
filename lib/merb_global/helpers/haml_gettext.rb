module Merb
  module Global
    module Helpers
      module HamlGettext
        # Inject _ gettext into plain text and tag plain text calls
        def push_plain(text)
          super(_(text.strip))
        end
        def parse_tag(line)
          tag_name, attributes, attributes_hash, object_ref, nuke_outer_whitespace,
            nuke_inner_whitespace, action, value = super(line)
          value = _(value) unless action || value.empty?
          [tag_name, attributes, attributes_hash, object_ref, nuke_outer_whitespace,
              nuke_inner_whitespace, action, value]
        end
      end
    end
  end
end

module Haml
  module Filters
    module Localize
      include ::Haml::Filters::Base
      extend Merb::Global
      def compile(precompiler, text)
        super(precompiler, _(text.strip).gsub('%{', '#{'))
      end
      
      def render(text)
        text
      end
    end
  end
end

Haml::Engine.send(:include, Merb::Global::Helpers::HamlGettext)
Haml::Engine.send(:include, Merb::Global)

# override template_for to differentiate templates by locale so our magic localized text will work
module Merb::Template
  class << self
    def template_name(path)
      Merb.logger.debug("custom template_name")
      path = File.expand_path(path)      
      path.gsub(/[^\.a-zA-Z0-9]/, "__").gsub(/\./, "_") + "locale_#{Merb::Global::Locale.current.to_s}"
    end
  
    def template_for(path, template_stack = [], locals=[])
      Merb.logger.debug("custom template_for #{path}")
      path = File.expand_path(path)
      path_with_locale = path + "locale_#{Merb::Global::Locale.current.to_s}"
      if needs_compilation?(path_with_locale, locals)
        template_io = load_template_io(path)
        METHOD_LIST[path_with_locale] = inline_template(template_io, locals) if template_io
      end

      METHOD_LIST[path_with_locale]
    end
  end
end

module Merb
  class Controller
    class << self
      def _templates_for
        Merb.logger.debug("MY _templates_for")
        @_templates_for ||= LocaleDependentHash.new
      end
    end
  end
end

class LocaleDependentHash < Hash
  def [](k)
    super(key_with_locale(k))
  end
  
  def []=(k,v)
    super(key_with_locale(k), v)
  end
  
  def key_with_locale(k)
    key = k.dup
    key << Merb::Global::Locale.current.to_s
    key
  end
end
