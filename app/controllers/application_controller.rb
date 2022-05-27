require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative '../models/table'

class ApplicationController < Sinatra::Base

  def initialize
    super
    @@score = 0
  end

  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/' do
    erb :index
  end

  post '/setup' do
    binding.pry
    @@table = Table.new({ range: params.values[0..-2].map(&:to_i), count: params[:count]})
    redirect '/play'
  end

  get '/play' do
    @@question = @@table.pick
    @button_words = button_word_choice(true)
    erb :quiz
  end

  post '/play' do
    @correct = evaluate_score
    @button_words = button_word_choice(@correct)
    if @correct
      redirect @@table.empty? ? '/end' : '/play'
    else
      erb :quiz
    end
  end

  private

  def evaluate_score
    if @@question.correct_answer?(params[:answer].to_i)
      correct = true
      @@score += 1
    else
      correct = false
      @@score -= 1
      @@table.return(@@question)
    end
    correct
  end

  def button_word_choice(correct)
    if correct
      ['Go go go!', 'You got this!', 'Keep it up!'].sample
    else
      ['Try again!', 'Not quite!', 'Oops...!'].sample
    end
  end
end
