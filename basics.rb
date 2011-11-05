# encoding: utf-8

require './lib/happy_people'
require './models/subscriber'

class MyApp < Sinatra::Base
  include Desconf::HappyPeople
  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/templates'
  set :slim, pretty: true

  before do
    redirect "http://desconf.com.br" if heroku_host?
  end

  def heroku_host?
    request.host.match(/heroku/)
  end

  def registration_open?
    true
  end

  def speaker_code
    variants = %w{9BE5FF902D2D815DD41A6FB3E6D6797F C1B8B60BDBDB37A994A45FA1834F796A 5BB518FA8080A6F774912FBD6E460451 4B56643D1B1B54F2241C6FB96D869205}
    variants[rand(variants.size)]
  end

  def render_index(locals = {})
    slim :index, locals: locals
  end

  get '/' do
    render_index
  end

  get '/paguei-seu-lindo' do
    render_index(thankyou: 'Uhuuul! Nos vemos lá! <br /> Enquanto isso vou ficar processando seu pagamento aqui! Valeuzão!')
  end

  get '/css/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :"sass/#{params['name']}", Compass.sass_engine_options
  end

  post '/' do
    s = Subscriber.create({
      :name => params[:name],
      :email => params[:mail],
      :created_at => Time.now
    })
    
    redirect "/"
  end
end
