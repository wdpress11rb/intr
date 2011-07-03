class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']
    unless user = User.find_by_provider_and_uid(
                          auth['provider'], auth['uid'])
      user = User.new({
        :name => auth['user_info']['nickname'],
        :provider => auth['provider'],
        :uid => auth['uid'],
        :access_token => auth['credentials']['token'],
        :access_secret => auth['credentials']['secret'],
      })
      user.save!
    end
    self.current_user = user
    redirect_to dashboard_path
  end

  def destroy
    self.sign_out!
    redirect_to root_path
  end

  def failure
    logger.warn "Auth Failed: " + params[:message]
    redirect_to root_path
  end
end
