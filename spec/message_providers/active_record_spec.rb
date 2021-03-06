require 'spec_helper'

if HAS_AR

  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3',
                                          :database => ':memory:')
  ActiveRecord::Migration.verbose = false

  require 'merb_global/message_providers/active_record'

  load    Pathname(__FILE__).dirname.parent.parent.expand_path +
          'activerecord_generators/translations_migration/templates/' +
          'translations_migration.erb'

  describe Merb::Global::MessageProviders::ActiveRecord::AddTranslationsMigration do
    before do
      @migration =
        Merb::Global::MessageProviders::ActiveRecord::AddTranslationsMigration
    end

    describe '.up' do
      after do
        @migration.down
      end

      it 'should run the migration' do
       @migration.up
      end
    end

    describe '.down' do
      before do
        @migration.up
      end

      it 'should revert the migration' do
        @migration.down
      end
    end
  end

  describe Merb::Global::MessageProviders::ActiveRecord do
    before do
      @provider = Merb::Global::MessageProviders::ActiveRecord.new
      @migration =
          Merb::Global::MessageProviders::ActiveRecord::AddTranslationsMigration
      @migration.up
    end

    after do
      @migration.down
    end

    describe '.create!' do
      it 'should check if migration exists and print message if yes' do
        file = mock do |file|
          file.expects(:=~).with(/translations\.rb/).returns(true)
        end
        dir = File.join Merb.root, 'schema', 'migrations', '*.rb'
        dir_mock = mock do |dir_mock|
          dir_mock.expects(:detect).yields(file).returns(true)
        end
        Merb::Global::MessageProviders::ActiveRecord::Dir = mock do |dir_class|
          dir_class.expects(:[]).with(dir).returns(dir_mock)
        end
        @provider.expects(:puts)
        @provider.create!
      end

      it 'should run the script if migration exists' do
        file = mock do |file|
          file.expects(:=~).with(/translations\.rb/).returns(true)
        end
        dir = File.join Merb.root, 'schema', 'migrations', '*.rb'
        dir_mock = mock do |dir_mock|
          dir_mock.expects(:detect).yields(file).returns(false)
        end
        Merb::Global::MessageProviders::ActiveRecord::Dir = mock do |dir_class|
          dir_class.stubs(:[]).with(dir).returns(dir_mock)
        end
        @provider.expects(:sh).with(%{merb-gen translations_migration})
        @provider.create!
      end
    end

    describe '.localize' do
      before do
        lang = Merb::Global::MessageProviders::ActiveRecord::Language
        trans = Merb::Global::MessageProviders::ActiveRecord::Translation
        en = lang.create! :name => 'en', :nplural => 2, :plural => 'n==1?0:1'
        trans.create! :language_id => en.id,
                      :msgid => 'Test', :msgid_plural => 'Tests',
                      :msgstr => 'One test', :msgstr_index => 0
        trans.create! :language_id => en.id,
                      :msgid => 'Test', :msgid_plural => 'Tests',
                      :msgstr => 'Many tests', :msgstr_index => 1
        trans.create! :language_id => en.id,
                      :msgid => 'Hello', :msgid_plural => nil,
                      :msgstr => 'Hello world!', :msgstr_index => nil
      end

      it 'should find it in database and return proper translation' do
        en = Merb::Global::Locale.new('en')
        trans = @provider.localize 'Test', 'Tests', 1, en
        trans.should == 'One test'
        trans = @provider.localize 'Test', 'Tests', 2, en
        trans.should == 'Many tests'
        trans = @provider.localize 'Hello', nil, 1, en
      end

      it 'should fallback if not' do
        fr = Merb::Global::Locale.new('fr')
        en = Merb::Global::Locale.new('en')
        trans = @provider.localize 'Test', 'Tests', 1, fr
        trans.should == 'Test'
        trans = @provider.localize 'Car', 'Cars', 2, en
        trans.should == 'Cars'
      end
    end

    describe '.import' do
      before do
        lang = Merb::Global::MessageProviders::ActiveRecord::Language
        trans = Merb::Global::MessageProviders::ActiveRecord::Translation
        en = lang.create! :name => 'en', :nplural => 2, :plural => 'n==1?0:1'
        trans.create! :language_id => en.id,
                      :msgid => 'Test', :msgid_plural => 'Tests',
                      :msgstr => 'One test', :msgstr_index => 0
        trans.create! :language_id => en.id,
                      :msgid => 'Test', :msgid_plural => 'Tests',
                      :msgstr => 'Many tests', :msgstr_index => 1
        trans.create! :language_id => en.id,
                      :msgid => 'Hello', :msgid_plural => nil,
                      :msgstr => 'Hello world!', :msgstr_index => nil
      end
      
      it 'should put data in the hash' do
        @provider.import.should == {
          "en" => {
            :nplural => 2, :plural => 'n==1?0:1',
            'Hello' => {
              :plural => nil,
              nil => 'Hello world!'
            },
            'Test' => {
              :plural => 'Tests',
              0 => 'One test',
              1 => 'Many tests'
            }
          }
        }
      end
    end

    describe '.export' do
      it 'should transform data from hash into the database' do
        lang = Merb::Global::MessageProviders::ActiveRecord::Language
        trans = Merb::Global::MessageProviders::ActiveRecord::Translation
        en = mock do |en|
          en.stubs(:id).returns(1)
        end
        lang.expects(:create!).
             with(:name => 'en', :nplural => 2, :plural => 'n==1?0:1').
             returns(en)
        trans.expects(:create!).
              with(:language_id => en.id,
                   :msgid => 'Test', :msgid_plural => 'Tests',
                   :msgstr => 'One test', :msgstr_index => 0)
        trans.expects(:create!).
              with(:language_id => en.id,
                   :msgid => 'Test', :msgid_plural => 'Tests',
                   :msgstr => 'Many tests', :msgstr_index => 1)
        trans.expects(:create!).
              with(:language_id => en.id,
                   :msgid => 'Hello', :msgid_plural => nil,
                   :msgstr => 'Hello world!', :msgstr_index => nil)
        @provider.export("en" => {
                           :nplural => 2, :plural => 'n==1?0:1',
                           'Hello' => {
                             :plural => nil,
                             nil => 'Hello world!'
                           },
                           'Test' => {
                             :plural => 'Tests',
                             0 => 'One test',
                             1 => 'Many tests'
                           }
                         })
      end
    end
  end
end
