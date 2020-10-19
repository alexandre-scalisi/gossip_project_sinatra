require 'bundler'
require 'gossip'
require 'csv'
Bundler.require

class ApplicationController < Sinatra::Base
 
  get '/' do
      erb :index, locals: {gossips: Gossip.all}
  end


  run! if app_file == $0

  get '/gossips/new/' do 
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    int_id = params['id'].to_i
    erb :show, locals:{gossips: Gossip.find(int_id), id: int_id}
  end
  
  get '/gossips/:id/edit/' do
    erb :edit ,locals:{id: params["id"]}
  end

  post '/gossips/:id/edit/' do
    

    Gossip.update(params["id"].to_i ,[params["gossip_author"],params["gossip_content"]])
    redirect '/'
  end

end

