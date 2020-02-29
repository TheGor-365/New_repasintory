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

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get 'public/info.txt' do
  erb "<a href='/public/info.txt'></a>"
end

post '/login/form' do
  @login = params[:login]
  @password = params[:password]

  if @login == "Gor" && @password == "123"

    return "<a href='public/info.txt'></a>"
  else
    @error = "Wrong login or password"
    return erb :login_form
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

  # visit_form_alerts.each do |key, value|
  #
  #   if params[key] == ''
  #     @error = visit_form_alerts[key]
  #     return erb :visit
  #   end
  # end

  @error = visit_form_alerts.select {|key,_| params[key] == ""}.values.join(", ")

  if @errof != ""
    return erb :visit
  end

  visiters = File.open 'public/info.txt', 'a'
  visiters.write "Date and time: #{@date_time} | Phone: #{@phone} | Username: #{@username} | Barber: #{@barber} | Color: #{@color}\n"
  visiters.close

  @message = "YOUR INFO IS SENDED:\n\nDate and time: #{@date_time} | Phone: #{@phone} | Username: #{@username} | Barber: #{@barber} | Color: #{@color}"
  erb :visit
end

post '/contacts' do
  @email = params[:email]
  @comment = params[:comment]

  if @email == ''
    @error = "Need to input email"
  end

  contacts = File.open 'public/info_2.txt', 'a'
  contacts.write "Mail - #{@email}:\nComment: #{@comment}\n\n"
  contacts.close

  @message = "YOUR INFO IS SENDED" if @mail != ''
  erb :contacts
end
