require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative '../models/table'
require_relative '../models/score'
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/' do
    erb :index
  end

  post '/setup' do
    table = Table.new({ range: params.values[0..-2].map(&:to_i), count: params[:count]})
    @@score = Score.new(table)
    redirect '/play'
  end

  get '/play' do
    @@score.next_question
    erb :quiz
  end

  post '/play' do
    if @@score.correct?(params[:answer].to_i)
      redirect @@score.last_question? ? '/end' : '/play'
    else
      erb :quiz
    end
  end

  get '/end' do
    erb :end
  end
end
