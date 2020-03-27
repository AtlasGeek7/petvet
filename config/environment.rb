require "bundler"
Bundler.require
require 'sinatra/json'
require "sinatra/cookies"

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/development.sqlite"
  )

require_all "app"
