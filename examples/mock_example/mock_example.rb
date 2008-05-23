# Load the merb_global from current tree
Gem.clear_paths
Gem.path.unshift Pathname(__FILE__).dirname.parent.parent.expand_path + 'lib'
$LOAD_PATH.unshift Pathname(__FILE__).dirname.parent.parent.expand_path + 'lib'

module Merb::Plugins
  def self.config
    {:merb_global => {:provider => :mock}}
  end
end

require 'merb_global'

Merb::Router.prepare do |r|
  r.match('/').to(:controller => 'mock_example', :action =>'index')
end

class MockExample < Merb::Controller
  def index
    _("Hi! Hello world!")
  end
end

Merb::Config.use { |c|
  c[:framework]           = {},
  c[:session_store]       = 'none',
  c[:exception_details]   = true
}
