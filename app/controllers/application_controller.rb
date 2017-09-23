class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
  	@teams= Team.search(params[:n1],params[:n2])
  	@team=@teams.first
  end

  def list
  	@disney_scrape=Scraper.new('fakeurl.com')
  end
end
