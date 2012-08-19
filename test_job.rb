# coding: utf-8

require 'haml'
require 'rack-flash' # flash support
require File.expand_path('../models/video', __FILE__) # load video model
require File.expand_path('../lib/helpers', __FILE__)  # load helpers

class TestJob < Sinatra::Base
  enable :sessions
  use Rack::Flash, sweep: true

  set :method_override, true # hidden input can change method
  set :haml, format: :html5
  set :public_folder, File.dirname(__FILE__) + '/public'

  helpers do
    include Helpers
  end

  before %r{/video} do
    begin
      id = request.path_info.gsub(/\D/, '').to_i

      @video = if id > 0
                 Video.find(id)
               else
                 Video.new(params[:video])
               end
    rescue ActiveRecord::RecordNotFound
      not_found
    end
  end

  get %r{/video/\d+} do
    if request.xhr?
      erb :'show.js', layout: false
    else
      haml :show
    end
  end

  get '/video/new' do
    haml :new
  end

  post '/video' do
    @video.save

    if request.xhr?
      erb :'create.js', layout: false
    else
      if @video.persisted?
        flash[:notice] = 'Запись успешно добавлена'
        redirect "/video/#{@video.id}"
      else
        flash[:error] = 'Невозможно сохранить запись'
        haml :new
      end
    end
  end

  delete '/video/:id' do
    if (@video.performed? or @video.failed?) and @video.destroy
      flash[:notice] = 'Запись успешно удалена'
    else
      flash[:error] = 'Невозможно удалить запись'
    end

    redirect '/'
  end

  get '/' do
    @videos = Video.order('created_at DESC')
    haml :index
  end

  not_found do
    erb :'404', layout: false
  end
end
