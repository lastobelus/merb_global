require 'spec_helper'

class TestController < Merb::Controller
  def index
    'index'
  end
end

class FrTestController < Merb::Controller
  locale {'fr'}
  def index
    "index"
  end
end

class FrTestController2 < Merb::Controller
  language {'fr'}
  def index
    "index"
  end
end

class SettableTestController < Merb::Controller
  attr_accessor :current_lang
  locale {@current_lang}
  def index
    'index'
  end
end

describe Merb::Controller do
  it 'should set language to english by default' do
    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env.delete 'HTTP_ACCEPT_LANGUAGE'
    end
    Merb::Global::Locale.current.should == Merb::Global::Locale.new('en')
  end

  it 'should set language according to the preferences' do
    Merb::Global::Locale.stubs(:support?).returns(true)
    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] = 'fr'
    end
    Merb::Global::Locale.current.should == Merb::Global::Locale.new('fr')
  end

  it 'should use default locale when none of the ACCEPT_LANGUAGEs are supported' do
    Merb::Global::Locale.stubs(:support?).returns(false)
    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] = 'fr-FR'
    end
    Merb::Global::Locale.current.should == Merb::Global::Locale.new('en')
  end

  it 'should take the weights into account' do
    de = Merb::Global::Locale.new('de')
    Merb::Global.stubs(:config).with('locales', ['en']).returns(['de', 'es'])
    Merb::Global.stubs(:config).with(:locale_in_session, false).returns(false)

    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] =
        'de;q=0.8,en;q=1.0,es;q=0.6'
    end
    Merb::Global::Locale.current.should == de
  end

  it 'should assume 1.0 as default weight' do
    it = Merb::Global::Locale.new('it')
    Merb::Global::Locale.stubs(:support?).returns(true)
    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] = 'it,en;q=0.7'
    end
    Merb::Global::Locale.current.should == it
  end

  it 'should choose language if \'*\' given' do
    fr = Merb::Global::Locale.new('fr')
    en = Merb::Global::Locale.new('en')
    Merb::Global.stubs(:config).with('locales', ['en']).returns(['en','fr'])
    Merb::Global.stubs(:config).with(:locale_in_session, false).returns(false)
    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] = '*,en;q=0.7'
    end
    Merb::Global::Locale.current.should == fr
  end

  it 'should have overriden settings by language/locale block' do
    en = Merb::Global::Locale.new('en')
    fr = Merb::Global::Locale.new('fr')
    [FrTestController, FrTestController2].each do |controller_class|
      controller = dispatch_to(controller_class, :index) do |controller|
        controller.request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
      end
      Merb::Global::Locale.current.should == fr
    end
  end

  it 'should evaluate in the object context' do
    fr = Merb::Global::Locale.new('fr')
    controller = dispatch_to(SettableTestController, :index) do |controller|
      controller.current_lang = 'fr'
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
    end
    Merb::Global::Locale.current.should == fr
  end

  it 'should fallback to lang if lang_REGION is not supported' do
    pt = Merb::Global::Locale.new('pt')
    Merb::Global.stubs(:config).with('locales', ['en']).returns(['pt'])    
    Merb::Global.stubs(:config).with(:locale_in_session, false).returns(false)
    controller = dispatch_to(TestController, :index) do |controller|
      controller.request.env['HTTP_ACCEPT_LANGUAGE'] = 'es-ES,pt-BR;q=0.7'
    end
    Merb::Global::Locale.current.should == pt
  end
  
  it 'should work with hyphen as locale separator' do
    derschweize = Merb::Global::Locale.new('fr-CH')
    Merb::Global.stubs(:config).with(:locale_in_session, false).returns(false)
    controller = dispatch_to(TestController, :index, :locale => 'fr-CH') do |controller|
      controller.request.env.delete 'HTTP_ACCEPT_LANGUAGE'
    end
    Merb::Global::Locale.current.should == derschweize
    Merb::Global::Locale.current.language.should == 'fr'
    Merb::Global::Locale.current.country.should == 'CH'    
  end

  it 'should work with underscore as locale separator' do
    derschweize = Merb::Global::Locale.new('fr-CH')
    Merb::Global.stubs(:config).with(:locale_in_session, false).returns(false)
    controller = dispatch_to(TestController, :index, :locale => 'fr_CH') do |controller|
      controller.request.env.delete 'HTTP_ACCEPT_LANGUAGE'
    end
    Merb::Global::Locale.current.should == derschweize
    Merb::Global::Locale.current.language.should == 'fr'
    Merb::Global::Locale.current.country.should == 'CH'    
  end

end
