class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    unless signed_in?
      redirect_to root_path
    else
      @user = current_user
      @friends = case @user.provider
                 when 'twitter'
                   friends_from_twitter
                 when 'facebook'
                   friends_from_facebook
                 end
    end
  end

  private
  def twitter_client
    ::Twitter::Client.new(
      :oauth_token => @user.access_token,
      :oauth_token_secret => @user.access_secret
    )
  end

  def friends_from_twitter
    twitter_client.friends.users.map{|user|
      {
        :id => user.id,
        :name => user.screen_name,
        :profile_url => user.profile_image_url
      }
    }
  end

  def facebook_client
    ::Koala::Facebook::GraphAPI.new(@user.access_token)
  end

  def friends_from_facebook
    facebook_client.get_connections("me","friends").map{|user|
      {
        :id => user["id"],
        :name => user["name"],
        :profile_url => "https://graph.facebook.com/#{user["id"]}/picture?type=square"
      }
    }
  end
end
