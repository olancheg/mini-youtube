require 'active_record'
require 'yaml'

DB_CONFIG = YAML.load_file('config/database.yml')['default']

ActiveRecord::Base.establish_connection DB_CONFIG
