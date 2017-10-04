# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
team_list=[
	["Carolina Hurricanes","CAR", "Eastern", "Metropolitan"],
	["Columbus Blue Jackets","CBJ", "Eastern", "Metropolitan"],
	["New Jersey Devils","NJD", "Eastern", "Metropolitan"],
	["New York Islanders","NYI", "Eastern", "Metropolitan"],
	["New York Rangers", "NYR", "Eastern", "Metropolitan"],
	["Philadelphia Flyers","PHI", "Eastern", "Metropolitan"],
	["Pittsburgh Penguins","PIT", "Eastern", "Metropolitan"],
	["Washington Capitals","WSH", "Eastern", "Metropolitan"],
	["Boston Bruins","BOS", "Eastern", "Atlantic"],
	["Buffalo Sabres","BUF", "Eastern", "Atlantic"],
	["Detroit Red Wings","DET", "Eastern", "Atlantic"],
	["Florida Panthers","FLA", "Eastern", "Atlantic"],
	["Montreal Canadiens","MTL", "Eastern", "Atlantic"],
	["Ottawa Senators","OTT", "Eastern", "Atlantic"],
	["Tampa Bay Lightning","TBL", "Eastern", "Atlantic"],
	["Toronto Maple Leafs","TOR", "Eastern", "Atlantic"],
	["Chicago Blackhawks", "CHI","Western", "Central"],
	["Colorado Avalanch","COL", "Western", "Central"],
	["Dallas Stars","DAL", "Western", "Central"],
	["Minnesota Wild","MIN", "Western", "Central"],
	["Nashville Predators","NSH", "Western", "Central"],
	["St. Louis Blues","STL", "Western", "Central"],
	["Winnipeg Jets","WPG", "Western", "Central"],
	["Anaheim Ducks","ANA", "Western", "Pacific"],
	["Arizona Coyotes","ARI", "Western", "Pacific"],
	["Calgary Flames", "CGY", "Western", "Pacific"],
	["Edmonton Oilers","EDM", "Western", "Pacific"],
	["Los Angeles Kings","LAK", "Western", "Pacific"],
	["San Jose Sharks","SJS", "Western", "Pacific"],
	["Vancouver Canucks","VAN", "Western", "Pacific"],
	["Vegas Golden Knights","VGK", "Western", "Pacific"]
]

team_list.each do |name,abbreviation, conf, div|
	Team.create(name: name, abbreviation: abbreviation, conference: conf, division: div)
end

require 'csv'
require 'set'

require 'pathname'
RailsRoot=Pathname.new(::Rails.root).expand_path
igs=CSV.read(RailsRoot + '/app/db/alligames.csv')
igs.sort_by!{|ig| ig[2]}
igs.reverse!

def getTeamId(name, games)
	games.each do |game|
		if game[0]==name
			return Team.find_by(abbreviation: game[1]).id
		end
	end
end


names=Set.new
igs.each do |game|
	names.add(game[0])
end

names.each do |name|
	id=getTeamId(name, igs)
	Player.create(name: name, team_id: id,lw: false,rw: false,c: false,d: false,g: false)
end


cumulative_games=[]
(0..81).each do |i|
	cgs=CSV.read(RailsRoot + "/app/db/cgames/cGames#{i}")
	cgs.each do |game|
		id=Player.find_by(name: game[0]).id
		if game[4]
			home_team_id=Team.find_by(abbreviation: game[1]).id
			away_team_id=Team.find_by(abbreviation: game[5]).id
		else
			away_team_id=Team.find_by(abbreviation: game[1]).id
			home_team_id=Team.find_by(abbreviation: game[5]).id
		end
		if home_team_id==Team.find_by("PIT").id
			cumulative_games.push(name: game[0],games_played: i, home_team_id: home_team_id, away_team_id: away_team_id,player_id: id, home: game[4],pos: game[2], date: game[3],goals: game[6], assists: game[7], points: (game[6].to_i+game[7].to_i),plus_minus: game[8], pim: game[9],ppg: game[10],ppa: game[11],ppp: (game[10].to_i+game[11].to_i), shg: game[12], sha: game[13], shp: (game[12].to_i+game[13].to_i), gwg: game[14], otg: game[15], shots: game[16], toi: game[17], shifts: game[18], hits: game[19], blocks: game[20], mss: game[21], gva: game[22], tka: game[23], fo: (game[24].to_i+game[25].to_i),fow: game[24],fol: game[25])
		end
	end
end
Cgame.create(cumulative_games)

new_games=[]
#igs.each do |game|
#	id=Player.find_by(name: game[0]).id
#	if game[4]
#		home_team_id=Team.find_by(abbreviation: game[1]).id
#		away_team_id=Team.find_by(abbreviation: game[5]).id
#	else
#		away_team_id=Team.find_by(abbreviation: game[1]).id
#		home_team_id=Team.find_by(abbreviation: game[5]).id
#	end
#	new_games.push(home_team_id: home_team_id, away_team_id: away_team_id,player_id: id, home: game[4],pos: game[2], date: game[3],goals: game[6], assists: game[7], points: (game[6].to_i+game[7].to_i),plus_minus: game[8], pim: game[9],ppg: game[10],ppa: game[11],ppp: (game[10].to_i+game[11].to_i), shg: game[12], sha: game[13], shp: (game[12].to_i+game[13].to_i), gwg: game[14], otg: game[15], shots: game[16], toi: game[18], shifts: game[19], hits: game[20], blocks: game[21], mss: game[22], gva: game[23], tka: game[24], fo: (game[25].to_i+game[26].to_i),fow: game[25],fol: game[26])
#end 
#Igame.create(new_games)






