#coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'timers'
require './model/sensor'

class ActiveSupport::TimeWithZone
    def as_json(options = {})
        strftime('%Y-%m-%d %H:%M:%S')
    end
end
set :database, {adapter: "sqlite3", database: "rpi.sqlite3"}

get '/' do
  "Hello"
end

post '/sensor/raw_data' do
  format = "%Y-%m-%d %H:%M:%S"
  s = Sensor.new
  s.number = params[:number]
  s.raw_value = params[:voltage]
  s.measured_at = Time.now.strftime(format)
  s.is_uploaded = false
  if s.save
    puts s.to_json
  else
    puts 'failed'
  end
end


