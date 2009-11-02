# -*- coding: utf-8 -*-
require 'spec_helper'
require 'stringio'

def configure_merb_for_haml
  Merb::Plugins.config[:merb_global] = {
    :provider => 'gettext',
    :localedir => File.join('spec', 'locale')
  }

  Merb::Config[:reload_templates] = true

  Merb.remove_paths(:view)
  Merb.push_path(:view,       Merb.root / "spec" / "haml" / "templates",       "**/*.rb")

  dependency 'merb-haml'

  load 'haml/haml_spec_helper.rb'
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
        configure_merb_for_haml
        @provider = Merb::Global::MessageProviders::Gettext.new
      end
      
      describe "in merb" do
        it "should render a haml template" do
          response = dispatch_to(TestHaml, :index)
          response.should be_successful
        end

        describe "with the default locale" do
          before do
            Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('en'))
            response = dispatch_to(TestHaml, :index)            
            @body = response.body
          end

          before do
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
            @body.should have_selector(".interpolation", :content => "text in localize filter with 47 interpolations")
          end

        end



        describe "with the polish locale" do
          before do
            Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('pl'))
            response = dispatch_to(TestHaml, :index)            
            @body = response.body
          end

          it "should translate with underscore method in script blocks" do
            @body.should have_selector(".underscore", :content => "Underscore Polish Text")
          end

          it "should translate inline plain text" do
            @body.should have_selector(".inline", :content => "Inline Polish Text")
          end

          it "should translate blocks of plain text" do
            @body.should have_selector(".block", :content => "block of Polish text")
          end

          it "should provide a :localize filter" do
            @body.should have_selector(".localize_filter", :content => "text is Polish in localize filter")
          end

          it "should do interpolation in translations" do
            @body.should have_selector(".interpolation", :content => "text in localize filter is Polish and has interpolations (47 of them)")
          end

        end
      end
      
      describe "with reload_templates off" do
        before do
          Merb::Config[:reload_templates] = false
        end
        
        it "should cache template_methods per locale" do
          Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('pl'))
          response = dispatch_to(TestHaml, :index)            
          response.body.should have_selector(".inline", :content => "Inline Polish Text")
          response.body.should have_selector(".block", :content => "block of Polish text")
          response.body.should have_selector(".localize_filter", :content => "text is Polish in localize filter")
          response.body.should have_selector(".interpolation", :content => "text in localize filter is Polish and has interpolations (47 of them)")
          Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('en'))
          response = dispatch_to(TestHaml, :index)            
          response.body.should have_selector(".block", :content => "block of text")
          response.body.should have_selector(".inline", :content => "Inline Text")
          response.body.should have_selector(".localize_filter", :content => "text in localize filter")
          response.body.should have_selector(".interpolation", :content => "text in localize filter with 47 interpolations")
          Merb::Global::Locale.stubs(:current).returns(Merb::Global::Locale.new('pl'))
          response = dispatch_to(TestHaml, :index)            
          response.body.should have_selector(".inline", :content => "Inline Polish Text")
          response.body.should have_selector(".block", :content => "block of Polish text")
          response.body.should have_selector(".localize_filter", :content => "text is Polish in localize filter")
          response.body.should have_selector(".interpolation", :content => "text in localize filter is Polish and has interpolations (47 of them)")
        end
      end
      
    end
  end
end

