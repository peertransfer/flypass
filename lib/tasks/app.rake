namespace :db do
  require "sequel"
  require "sqlite3"

  Sequel.extension :migration
  DB = Sequel.sqlite("./db/development.db")

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

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, :target do |t, args|
    migrations_directory = "#{File.dirname(__FILE__)}/../../db/migrations"
    args.with_defaults(:target => 0)

    Sequel::Migrator.run(DB, migrations_directory, :target => args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc "Perform migration reset (full rollback and migration)"
  task :reset do
    migrations_directory = "#{File.dirname(__FILE__)}/../../db/migrations"
    Sequel::Migrator.run(DB, migrations_directory, :target => 0)
    Sequel::Migrator.run(DB, migrations_directory)
    Rake::Task['db:version'].execute
  end
end
