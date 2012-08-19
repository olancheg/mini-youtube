require 'rake'
require 'active_record'
require 'logger'
require File.expand_path('../db_connect', __FILE__)

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
