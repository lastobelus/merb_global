require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'

PLUGIN = "merb_global"
NAME = "merb_global"
GEM_VERSION = "0.0.7"
AUTHORS = ["Alex Coles", "Maciej Piechotka"]
EMAIL = "merb_global@googlegroups.com"
HOMEPAGE = "http://trac.ikonoklastik.com/merb_global/"
SUMMARY = "Localization (L10n) and Internationalization (i18n) support for the Merb MVC Framework"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = NAME
    gemspec.summary = SUMMARY
    gemspec.description = gemspec.summary
    gemspec.email = EMAIL
    gemspec.homepage = HOMEPAGE
    gemspec.authors = AUTHORS
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc "Install merb_global"
task :install => [:package] do
  sh %{gem install pkg/#{NAME}-#{GEM_VERSION}}
end

Rake::RDocTask.new do |rd|
  rd.rdoc_dir = "doc"
  rd.rdoc_files.include "lib/**/*.rb"
end

desc "Creates database for examples"
task :populate_db do
  require 'fileutils'
  pwd = File.dirname __FILE__
  db = "#{pwd}/examples/database.db"
  sh %{sqlite3 #{db} < #{pwd}/examples/database.sql}
  FileUtils.cp db, "#{pwd}/examples/active_record_example/database.db"
  FileUtils.cp db, "#{pwd}/examples/data_mapper_example/database.db"
  FileUtils.cp db, "#{pwd}/examples/sequel_example/database.db"
end
task "pkg/#{NAME}-#{GEM_VERSION}" => [:populate_db]

require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('specs') do |st|
  st.libs = ['lib', 'spec']
  st.spec_files = FileList['spec/**/*_spec.rb']
  st.spec_opts = ['--format specdoc', '--color']
end

desc "Run rcov"
Spec::Rake::SpecTask.new('rcov') do |rct|
  rct.libs = ['lib', 'spec']
  rct.rcov = true
  rct.rcov_opts = ['-x gems', '-x usr', '-x spec']
  rct.spec_files = FileList['spec/**/*.rb']
  rct.spec_opts = ['--format specdoc', '--color']
end
