namespace :db do
  require "sequel"
  Sequel.extension :migration
  DB = Sequel.sqlite

  desc "Prints current schema version"
  task :version do
    version = if DB.tables.include?(:schema_info)
      DB[:schema_info].first[:version]
    end || 0

    puts "Schema Version: #{version}"
  end

  desc "Perform migration up to latest migration available"
  task :migrate do
    migrations_directory = "#{File.dirname(__FILE__)}/../../db/migrations"
    Sequel::Migrator.run(DB, migrations_directory)
    Rake::Task['db:version'].execute
  end
end
