#coding: utf-8
require 'sinatra'
require 'sinatra/reloader'



get '/hello/:name' do
      "Hello #{params['name']}!"
end

post '/hello/:name' do
  @voltage = params[:voltage]
  erb :template
end

