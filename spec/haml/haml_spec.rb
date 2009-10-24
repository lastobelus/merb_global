# -*- coding: utf-8 -*-
require 'spec_helper'
require 'stringio'


def test_render(text, options = {}, &block)
  scope  = options.delete(:scope)  || Object.new
  locals = options.delete(:locals) || {}
  test_engine(text, options).to_html(scope, locals, &block)
end

def test_engine(text, options = {})
  unless options[:filename]
    # use caller method name as fake filename. useful for debugging
    i = -1
    caller[i+=1] =~ /`(.+?)'/ until $1 and $1.index('test_') == 0
    options[:filename] = "(#{$1})"
  end
  Haml::Engine.new(text, options)
end

def test_template(name)
end

Merb::Global::Locale
if HAS_GETTEXT

  require 'merb_global/message_providers/gettext'
  
  if HAS_HAML
    require 'merb_global/helpers/haml_gettext'

    describe Merb::Global::Helpers::HamlGettext do
      before do
        @provider = Merb::Global::MessageProviders::Gettext.new
      end
      
      describe "with the default locale" do
        before do
          Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('en'))
        end
        
        describe "basic" do
          before do
          end
          
          it "should translate with underscore method in script blocks"          
          it "should translate inline plain text"
          it "should translate blocks of plain text"
          it "should provide a :localize filter"
        end
      end
      
    end
  end
end

