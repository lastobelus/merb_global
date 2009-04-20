# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "merb_global"
  s.version = "0.0.12"
  s.platform = Gem::Platform::RUBY
  s.summary = "Localization (L10n) and Internationalization (i18n) support for the Merb MVC Framework"
  s.description = s.summary
  s.authors = ["Alex Coles", "Maciej Piechotka", "Michael Johnston"]
  s.email = "merb_global@googlegroups.com"
  s.homepage = "http://trac.ikonoklastik.com/merb_global/"
  s.rubyforge_project = 'merb-global'
  s.add_dependency('merb-core', '>= 0.9.1')
  s.add_dependency('gettext', '>= 2.0.0')
  s.add_dependency('treetop', '>= 1.2.3') # Tested on 1.2.3
  s.add_dependency('polyglot', '>= 0.2.5')
  s.add_dependency('composite_primary_keys', '>= 2.0')
  s.require_path = 'lib'
  s.autorequire = "merb_global"
  s.files = %w(LICENSE README Rakefile TODO HISTORY lib/merb_global lib/merb_global/base.rb lib/merb_global/config.rb lib/merb_global/controller.rb lib/merb_global/date_providers lib/merb_global/date_providers/fork.rb lib/merb_global/date_providers.rb lib/merb_global/helpers lib/merb_global/helpers/haml_gettext.rb lib/merb_global/locale.rb lib/merb_global/merbrake.rb lib/merb_global/message_providers lib/merb_global/message_providers/active_record.rb lib/merb_global/message_providers/data_mapper.rb lib/merb_global/message_providers/gettext.rb lib/merb_global/message_providers/gettext.treetop lib/merb_global/message_providers/mock.rb lib/merb_global/message_providers/sequel.rb lib/merb_global/message_providers/yaml.rb lib/merb_global/message_providers.rb lib/merb_global/numeric_providers lib/merb_global/numeric_providers/fork.rb lib/merb_global/numeric_providers/java.rb lib/merb_global/numeric_providers.rb lib/merb_global/parsers lib/merb_global/parsers/haml_parser.rb lib/merb_global/plural.rb lib/merb_global/plural.treetop lib/merb_global/providers.rb lib/merb_global.rb activerecord_generators/translations_migration activerecord_generators/translations_migration/templates activerecord_generators/translations_migration/templates/translations_migration.erb activerecord_generators/translations_migration/translations_migration_generator.rb activerecord_generators/translations_migration/USAGE sequel_generators/translations_migration sequel_generators/translations_migration/templates sequel_generators/translations_migration/templates/translations_migration.erb sequel_generators/translations_migration/translations_migration_generator.rb sequel_generators/translations_migration/USAGE examples/active_record_example examples/active_record_example/application.rb examples/active_record_example/config examples/active_record_example/config/database.yml examples/active_record_example/config/framework.rb examples/active_record_example/config/init.rb examples/active_record_example/config/plugins.yml examples/active_record_example/README.txt examples/data_mapper_example examples/data_mapper_example/application.rb examples/data_mapper_example/config examples/data_mapper_example/config/database.yml examples/data_mapper_example/config/framework.rb examples/data_mapper_example/config/init.rb examples/data_mapper_example/config/plugins.yml examples/data_mapper_example/README.txt examples/database.sql examples/gettext_example examples/gettext_example/application.rb examples/gettext_example/config examples/gettext_example/config/framework.rb examples/gettext_example/config/init.rb examples/gettext_example/config/plugins.yml examples/gettext_example/locale examples/gettext_example/locale/merbapp.pot examples/gettext_example/locale/pl examples/gettext_example/locale/pl/LC_MESSAGES examples/gettext_example/locale/pl/LC_MESSAGES/merbapp.mo examples/gettext_example/locale/pl.po examples/gettext_example/README.txt examples/mock_example examples/mock_example/application.rb examples/mock_example/config examples/mock_example/config/framework.rb examples/mock_example/config/init.rb examples/mock_example/config/plugins.yml examples/mock_example/README.txt examples/sequel_example examples/sequel_example/application.rb examples/sequel_example/config examples/sequel_example/config/database.yml examples/sequel_example/config/framework.rb examples/sequel_example/config/init.rb examples/sequel_example/config/plugins.yml examples/sequel_example/README.txt examples/yaml_example examples/yaml_example/application.rb examples/yaml_example/config examples/yaml_example/config/framework.rb examples/yaml_example/config/init.rb examples/yaml_example/config/plugins.yml examples/yaml_example/locale examples/yaml_example/locale/en.yaml examples/yaml_example/locale/pl.yaml examples/yaml_example/README.txt)
  
  # rdoc
  s.has_rdoc = true
  s.extra_rdoc_files = %w(README LICENSE TODO HISTORY)
end
