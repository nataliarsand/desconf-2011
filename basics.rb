class MyApp < Sinatra::Base
  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/templates'

  get '/' do
    slim :index
  end

  get '/css/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :"sass/#{params['name']}", Compass.sass_engine_options
  end
end
