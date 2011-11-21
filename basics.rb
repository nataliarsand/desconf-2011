# encoding: utf-8

require './lib/happy_people'
require './lib/registration'
require './lib/host_verification'
require './models/subscriber'
require './models/desconf_attendee'
require './models/lightning_talk'

class MyApp < Sinatra::Base
  include Desconf::HappyPeople
  include Desconf::Registration
  include Desconf::HostVerification 

  set :public, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/templates'
  set :slim, pretty: true

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
  
  def attendee
    @attendee ||= Desconf::Attendee.find(params[:id])
  end

  def just_registrated?
    request.path =~ /paguei-seu-lindo/
  end

  get '/' do
    render_index
  end

  post '/pessoa_bacana/:id' do
    attendee.attributes = params[:attendee]
    unless attendee.save
      slim :attendee_form
    else
      redirect '/?registrado'
    end
  end

  get '/pessoa_bacana/:id/editar' do
    slim :attendee_form
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
