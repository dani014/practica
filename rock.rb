require 'sinatra'
require 'erb'

# before we process a route we'll set the response as plain text
# and set up an array of viable moves that a player (and the
# computer) can perform
before do
  @defeat = { rock: :scissor, paper: :rock, scissor: :paper}
  @throws = @defeat.keys
end

get '/' do
   erb :choice
end

get '/*' do
 redirect '/'
end

post '/throw' do

  # the params hash stores querystring and form data
  @player_throw = params[:option].to_sym #[:type].to_sym

  halt(403, "You must throw one of the following: '#{@throws.join(', ')}'") unless @throws.include? @player_throw

  @computer_throw = @throws.sample

  if @player_throw == @computer_throw
    @answer = "There is a tie"
    #erb :index
  elsif @player_throw == @defeat[@computer_throw]
    @answer = "Computer wins; #{@computer_throw} defeats #{@player_throw}"
    #erb :index
  else
    @answer = "Well done. #{@player_throw} beats #{@computer_throw}"
    #erb :index
  end
  erb :index
end
