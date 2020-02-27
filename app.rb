require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

get '/contacts' do
  erb :contacts
end

get '/' do
  erb :home
end

get '/login/form' do
  erb :login_form
end

post '/info.txt' do
  @login = params[:login]
  @password = params[:password]

  if @login != "Gor" && @password != "123"
    @error = "Wrong login or password"
    erb :login_form
  else
    erb "<a href='info.txt'></a>"
  end

end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end
