require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/about' do
  @error = 'This is error!'
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

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
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

post '/visit' do

  @username = params[:username]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @barber = params[:barber]
  @color = params[:color]

  visit_form_alerts = {
    :username => 'Input your name',
    :phone => 'Input your phone',
    :date_time => 'Input your visiting date and time'
  }

  visit_form_alerts.each do |key, value|

    if params[key] == ''
      @error = visit_form_alerts[key]
      return erb :visit
    end
  end

  # info = File.open '/info.txt', 'a'
  # info.write "Date and time: #{@date_time} | Phone: #{@phone} | Username: #{@username} Barber: #{@barber} | Color: #{@color}\n"
  # info.close

  @message = "Your info is sended:\n\nDate and time: #{@date_time} | Phone: #{@phone} | Username: #{@username} | Barber: #{@barber} | Color: #{@color}"
  erb :visit
end
