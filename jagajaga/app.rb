require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
require 'pry'

enable :sessions


helpers do
  def current_user
   @userr =  User.find_by(id: session[:user])
  end
end

get '/' do
   if current_user.nil? then
    redirect '/signin'
   else
  @courses = Course.all
  @users = User.all
  @quesitons = Question.all
  erb :index
   end
end

get '/signup' do
  erb :sign_up
end

post '/signup' do
  user = User.create(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    email: params[:email],
    simple_word:  params[:simple_word],
    color: params[:color],
    place:  params[:place],
  )
  if user.persisted?
      session[:user] = user.id
  end
  redirect '/'
end

get '/signin' do
  erb :sign_in
end

post  '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/questions/new' do
  erb :question_new
end

post '/questions' do
     course = Course.find(params[:course])
     current_user.questions.create!(title: params[:title],content:params[:content],course_id: course.id)
    redirect '/'
end


post '/questions/:id/delete' do
  question = Question.find(params[:id])
  question.destroy
  redirect '/'
end

get '/questions/:id/edit' do
  @question_edit = Question.find(params[:id])
  erb :question_edit
end

post '/questions/:id' do
  questions = Question.find(params[:id])
  course = Course.find(params[:course])
  questions.title = CGI.escapeHTML(params[:title])
  questions.course_id = course.id
  questions.save
  redirect '/'
end

get '/questions/:id/course' do
  courQues = Course.find_by(params[:id])
  @courQues = courQues.questions
  binding.pry
  @courses =  Course.all
  erb :questions_course
end
