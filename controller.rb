require ('sinatra')
require ('sinatra/contrib/all')
require ('pry')
require_relative ('./models/film')
also_reload('./models/*')

# list all films on index page
get '/films' do
  @all_films = Film.all()
  erb(:index)
end

# find the film by id that is taken from the url
get '/films/:id' do
  id = params[:id].to_i
  @film = Film.find_by_id(id)
  erb(:film)
end
