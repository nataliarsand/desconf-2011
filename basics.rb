# encoding: utf-8

require './lib/happy_people'
require './lib/registration'
require './models/subscriber'
require './models/desconf_attendee'
require './models/lightning_talk'

class MyApp < Sinatra::Base
  include Desconf::HappyPeople
  include Desconf::Registration

  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/templates'
  set :slim, pretty: true

  before do
    redirect "http://desconf.com.br" if heroku_host?
  end

  def heroku_host?
    request.host.match(/heroku/)
  end

  def render_index(locals = {})
    slim :index, locals: locals
  end

  def videos_from_2010
    LightningTalk.from_desconf_2010
  end

  def speakers 
    @speakers ||= Desconf::Attendee.where(type: 'speaker')
  end

  def listeners
    @listeners ||= Desconf::Attendee.where(type: 'listener')
  end

  def just_registrated?
    request.path =~ /paguei-seu-lindo/
  end

  get '/' do
    render_index
  end

  get '/paguei-seu-lindo' do
    render_index
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
