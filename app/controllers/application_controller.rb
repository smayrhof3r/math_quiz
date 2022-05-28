require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative '../models/table'

class ApplicationController < Sinatra::Base

  def initialize
    super
    @@score = 0
    @@questions_completed = 0
    @@total_questions = 0
    @@mistakes = 0
  end

  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/' do
    @@questions_completed = 0
    erb :index
  end

  post '/setup' do
    # unanswered:😐 right:🤓 wrong: 😥
    @@table = Table.new({ range: params.values[0..-2].map(&:to_i), count: params[:count]})
    @@total_questions = @@table.size
    @@status = '😐' * @@total_questions
    redirect '/play'
  end

  get '/play' do
    @@question = @@table.pick
    @button_words = button_word_choice(true)
    erb :quiz
  end

  post '/play' do
    @correct = evaluate_score
    @@questions_completed += 1 if @correct
    update_status(@correct)
    @button_words = button_word_choice(@correct)
    if @correct
      redirect @@table.empty? ? '/end' : '/play'
    else
      @@total_questions += 1
      @@status += '😐'
      @@mistakes += 1
      @@table.return(@@question)
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

  def update_status(correct)
    if correct
      @@status[@@questions_completed-1] = '🤓' unless @@status[@@questions_completed-1] == '😥'
    else
      @@status[@@questions_completed] = '😥'
    end
  end
end
