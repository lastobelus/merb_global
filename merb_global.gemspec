# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb_global}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Coles", "Maciej Piechotka"]
  s.date = %q{2009-09-30}
  s.description = %q{Localization (L10n) and Internationalization (i18n) support for the Merb MVC Framework}
  s.email = %q{merb_global@googlegroups.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README",
     "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "CONTRIBUTORS",
     "HISTORY",
     "LICENSE",
     "README",
     "README.markdown",
     "Rakefile",
     "TODO",
     "VERSION",
     "activerecord_generators/translations_migration/USAGE",
     "activerecord_generators/translations_migration/templates/translations_migration.erb",
     "activerecord_generators/translations_migration/translations_migration_generator.rb",
     "benchmarks/database1.rb",
     "examples/active_record_example/README.txt",
     "examples/active_record_example/application.rb",
     "examples/active_record_example/config/database.yml",
     "examples/active_record_example/config/framework.rb",
     "examples/active_record_example/config/init.rb",
     "examples/active_record_example/config/plugins.yml",
     "examples/data_mapper_example/README.txt",
     "examples/data_mapper_example/application.rb",
     "examples/data_mapper_example/config/database.yml",
     "examples/data_mapper_example/config/framework.rb",
     "examples/data_mapper_example/config/init.rb",
     "examples/data_mapper_example/config/plugins.yml",
     "examples/database.sql",
     "examples/gettext_example/README.txt",
     "examples/gettext_example/application.rb",
     "examples/gettext_example/config/framework.rb",
     "examples/gettext_example/config/init.rb",
     "examples/gettext_example/config/plugins.yml",
     "examples/gettext_example/locale/merbapp.pot",
     "examples/gettext_example/locale/pl.po",
     "examples/gettext_example/locale/pl/LC_MESSAGES/merbapp.mo",
     "examples/mock_example/README.txt",
     "examples/mock_example/application.rb",
     "examples/mock_example/config/framework.rb",
     "examples/mock_example/config/init.rb",
     "examples/mock_example/config/plugins.yml",
     "examples/sequel_example/README.txt",
     "examples/sequel_example/application.rb",
     "examples/sequel_example/config/database.yml",
     "examples/sequel_example/config/framework.rb",
     "examples/sequel_example/config/init.rb",
     "examples/sequel_example/config/plugins.yml",
     "examples/yaml_example/README.txt",
     "examples/yaml_example/application.rb",
     "examples/yaml_example/config/framework.rb",
     "examples/yaml_example/config/init.rb",
     "examples/yaml_example/config/plugins.yml",
     "examples/yaml_example/locale/en.yaml",
     "examples/yaml_example/locale/pl.yaml",
     "lib/merb_global.rb",
     "lib/merb_global/base.rb",
     "lib/merb_global/config.rb",
     "lib/merb_global/controller.rb",
     "lib/merb_global/date_providers.rb",
     "lib/merb_global/date_providers/fork.rb",
     "lib/merb_global/locale.rb",
     "lib/merb_global/merbrake.rb",
     "lib/merb_global/message_providers.rb",
     "lib/merb_global/message_providers/active_record.rb",
     "lib/merb_global/message_providers/data_mapper.rb",
     "lib/merb_global/message_providers/gettext.rb",
     "lib/merb_global/message_providers/gettext.treetop",
     "lib/merb_global/message_providers/mock.rb",
     "lib/merb_global/message_providers/sequel.rb",
     "lib/merb_global/message_providers/yaml.rb",
     "lib/merb_global/numeric_providers.rb",
     "lib/merb_global/numeric_providers/fork.rb",
     "lib/merb_global/numeric_providers/java.rb",
     "lib/merb_global/plural.rb",
     "lib/merb_global/plural.treetop",
     "lib/merb_global/providers.rb",
     "sequel_generators/translations_migration/USAGE",
     "sequel_generators/translations_migration/templates/translations_migration.erb",
     "sequel_generators/translations_migration/translations_migration_generator.rb",
     "spec/base_spec.rb",
     "spec/controller_spec.rb",
     "spec/date_providers_spec.rb",
     "spec/locale/merbapp.pot",
     "spec/locale/pl.po",
     "spec/locale/pl.yaml",
     "spec/locale/pl/LC_MESSAGES/merbapp.mo",
     "spec/message_providers/active_record_spec.rb",
     "spec/message_providers/data_mapper_spec.rb",
     "spec/message_providers/gettext_spec.rb",
     "spec/message_providers/mock_spec.rb",
     "spec/message_providers/sequel_spec.rb",
     "spec/message_providers/yaml_spec.rb",
     "spec/message_providers_spec.rb",
     "spec/numeric_providers_spec.rb",
     "spec/plural_spec.rb",
     "spec/providers_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://trac.ikonoklastik.com/merb_global/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Localization (L10n) and Internationalization (i18n) support for the Merb MVC Framework}
  s.test_files = [
    "spec/base_spec.rb",
     "spec/controller_spec.rb",
     "spec/date_providers_spec.rb",
     "spec/message_providers/active_record_spec.rb",
     "spec/message_providers/data_mapper_spec.rb",
     "spec/message_providers/gettext_spec.rb",
     "spec/message_providers/mock_spec.rb",
     "spec/message_providers/sequel_spec.rb",
     "spec/message_providers/yaml_spec.rb",
     "spec/message_providers_spec.rb",
     "spec/numeric_providers_spec.rb",
     "spec/plural_spec.rb",
     "spec/providers_spec.rb",
     "spec/spec_helper.rb",
     "examples/active_record_example/application.rb",
     "examples/active_record_example/config/framework.rb",
     "examples/active_record_example/config/init.rb",
     "examples/data_mapper_example/application.rb",
     "examples/data_mapper_example/config/framework.rb",
     "examples/data_mapper_example/config/init.rb",
     "examples/gettext_example/application.rb",
     "examples/gettext_example/config/framework.rb",
     "examples/gettext_example/config/init.rb",
     "examples/mock_example/application.rb",
     "examples/mock_example/config/framework.rb",
     "examples/mock_example/config/init.rb",
     "examples/sequel_example/application.rb",
     "examples/sequel_example/config/framework.rb",
     "examples/sequel_example/config/init.rb",
     "examples/yaml_example/application.rb",
     "examples/yaml_example/config/framework.rb",
     "examples/yaml_example/config/init.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
