class Player < ApplicationRecord
  belongs_to :team
  has_many :cgames
  has_many :igames
  def self.getAverage(categories, numgames)
  end
  
  def self.getCurrentStats(categories)
  	@current= Cgame.select(@categories).group('"player_id"').having('games_played = MAX(games_played)').sort_by{|g| g.name}
  end
  def self.getNGamesAgoStats(categories)
  	@ngamesAgo=Cgame.select(@categories).order(:games_played).group_by(&:name).map{|f| f.last[[f.last.length-10,0].max]}.sort_by{|g| g.name}
  end
end
