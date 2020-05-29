require 'bundler'
require 'tty-prompt'
require 'tty-table'
require 'colorize'
Bundler.require
ActiveRecord::Base.logger = nil

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

