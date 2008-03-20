class UtilityController < ApplicationController

  # query the shell to get the hostname for this computer
  def hostname
    begin
      hostname = `hostname`
      render :text => hostname
    rescue
      render :text => 'unknown'
    end
  end
  
end
