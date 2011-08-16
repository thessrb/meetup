$:.unshift File.dirname(__FILE__)
require 'sinatra'
require 'rake'
#load every file you find in the plugins directory
plugins=FileList["#{File.join(File.dirname(__FILE__),'plugins')}/*.rb"]
plugins.each{ |plugin| require plugin  }

module InformationRadiator
  class RadiatorApp<Sinatra::Base
    PLUGINS = [Plugins::Example]
    attr_reader :title,:drawing_function
    def self.define_settings 
      #the settings that are not public
      enable :logging
      enable :run
      enable :static
      set :server, %w[thin mongrel webrick]
      set :root,  File.dirname(__FILE__)
      set :public,  File.join(File.dirname(__FILE__) ,'public')
      set :views, File.join(File.dirname(__FILE__) ,'views')
      set :port,9000
      set :refresh,10
    end
    
    get '/:plugin' do |plug|
      #if there is a parameter, use it to get the plug-in class
      #but only if it is in our list
      if plug && plugins.include?(plug)
        plugin=Plugins.const_get("#{plug}")
      else
        #get the cookie and use it as an index to get the next plugin
        cookie = request.cookies['radiator'].to_i
        cookie||= 0
        cookie=0 if cookie>=PLUGINS.length
        plugin=PLUGINS[cookie]
        cookie+=1
        cookie=0 if cookie>=PLUGINS.length
        response.set_cookie('radiator',cookie)
      end
      @title="Information Radiator #{plugin}"
      cfg={:settings=>{:refresh=>settings.refresh}}
      @drawing_function=plugin.new(cfg).drawing_function
      erb :canvas
    end
    
    get '/info/index' do
      erb :index
    end
    def plugins
      @plugins||=[]
      PLUGINS.each do |plug|
        @plugins<<plug.name.split('::').last
      end
      return @plugins
    end
  end
end