class SettingsController < ApplicationController

  def index
    if request.post?
      if @system.update_attributes(params[:system])
        redirect_to :controller => 'dashboard'
      end
    end
  end
  
end
