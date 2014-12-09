require 'sinatra'
require 'sinatra/reloader' if development?

get "/" do
    @title = "Marin Guta's Portfolio"
    @description = "This site showcases all of Marin Guta's clips."
    @image = "img/main-bg.jpg"
    erb :home
    end


get "/resume" do
    @title = "Work Experience"
    @description = "This is what Marin Guta has accomplished."
    @image = "img/home-bg.jpg"
    erb :resume
    end

get "/about" do
    @title = "About Marin Guta"
    @description = "This is a little bit about Marin Guta."
    @image = "img/about-bg.jpg"
    erb :about
    end

get "/socialmedia" do        
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "sB0YXk3XqxzfdoP2skNIpua2y"
      config.consumer_secret     = "HPLeNS0hk24XGQd3m4EB3vyVpnuAeAUCFgZ4KXALc4F5F2iAl2"
      config.access_token        = "125217202-5DWutDPF2nLtGZNmK8mvwyJeUWgvZyoY5XULrlQx"
      config.access_token_secret = "kRX8VcgTtWaUtYfOMeCcs3uQlcjvrUROun1Diw6liuQ5B"
    end

    @search_results = client.user_timeline("@mercercluster").take(30).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
        tweet
    end
    
    require "sinatra"
    require "instagram"

    #enable :sessions

    CALLBACK_URL = "http://localhost:4567/oauth/callback"

    Instagram.configure do |config|
      config.client_id = "0ca8d979df9b4314b5ad4a212b227708"
      config.client_secret = "7b4e1b68be85413a98ec980db98bef66"
      # For secured endpoints only
      #config.client_ips = '<Comma separated list of IPs>'
    end
    

    
    @ig_results = [] 
      client = Instagram.client(:access_token => session[:access_token])
      #user = client.user
      #html = "<h1>#{user.username}'s recent media</h1>"
      for media_item in client.user_recent_media(1389181985)
                @ig_results.push(media_item) 
        #html << "<div style='float:left;'><img src='#{media_item.images.thumbnail.url}'><br/> <a href='/media_like/#{media_item.id}'>Like</a>  <a href='/media_unlike/#{media_item.id}'>Un-Like</a>  <br/>LikesCount=#{media_item.likes[:count]}</div>"
      end
    @title = "Social media expert"
    @description = "This site showcases all of the awesome things that Marin Guta has done."
    @image = "img/socialmedia-bg.jpg"
    erb :socialmedia
    end

get "/contact" do
    @title = "Contact Marin Guta"
    @description = "If you want to reach me, here is my contact information."
    @image = "img/contact-bg.jpg"
    erb :contact
    end