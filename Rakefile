# Rakefile
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :console do
  system("pry -r ./app.rb")
end
