# -*- coding: utf-8 -*-
require 'spec_helper'
require 'stringio'

class TestBase
  include Merb::Global
  def inum
    return 42
  end
end

def test_render(text, options = {}, &block)
  scope  = options.delete(:scope)  || TestBase.new
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
  name += '.html.haml'
  template_path = File.join(File.dirname(__FILE__),'templates',name)
  File.read(template_path)
end

if HAS_GETTEXT

  require 'merb_global/message_providers/gettext'
  
  if HAS_HAML_SPECS
    require 'merb_global/helpers/haml_gettext'

    describe Merb::Global::Helpers::HamlGettext do
      include Webrat::Matchers
      before do
        @provider = Merb::Global::MessageProviders::Gettext.new
      end
      
      describe "with the default locale" do
        before do
          Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('en'))
        end
        
        describe "basic" do
          before do
            @body = test_render(test_template('basic'))
          end
          
          it "should translate with underscore method in script blocks" do
            @body.should have_selector(".underscore", :content => "Underscore Text")
          end

          it "should translate inline plain text" do
            @body.should have_selector(".inline", :content => "Inline Text")
          end

          it "should translate blocks of plain text" do
            @body.should have_selector(".block", :content => "block of text")
          end
          
          it "should provide a :localize filter" do
            @body.should have_selector(".localize_filter", :content => "text in localize filter")
          end

          it "should do interpolation in translations" do
            @body.should have_selector(".interpolation", :content => "text in localize filter with 42 interpolations")
          end
          
        end
      end
      
    end
  end
end

