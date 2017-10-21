class Cgame < ApplicationRecord
  belongs_to :player
  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"
  
  def self.getCurrentStats(categories)
    result=ActiveRecord::Base.connection.execute("SELECT #{categories} FROM (SELECT ROW_NUMBER() OVER (PARTITION BY name ORDER BY games_played DESC) as r, cgames.* FROM cgames ) x WHERE x.r =1").values  
  end

  def self.getNGamesAgoStats(categories, n)
    result=ActiveRecord::Base.connection.execute("SELECT #{categories} FROM (SELECT ROW_NUMBER() OVER (PARTITION BY name ORDER BY games_played DESC) as r, cgames.* FROM cgames ) x WHERE x.r =#{n+1}").values  
  end

  def self.currentMinusNgames(current, ngamesago, numgames)
    current = current.slice(3,current.length-3)
    ngamesago = ngamesago.slice(3, ngamesago.length-3)
    stats=[]
    current.length.times do |i|
        stats<<current[i]-ngamesago[i]
    end
    stats
  end

  def self.reinsertNamesGames(stats, original, numGames) 
  	stats.zip(original.map{|player| [player[0],[player[2]+1,numGames].min, player[1]]}).map{|statLine, name_games, player_id| statLine.unshift(name_games[0],name_games[1]).push(player_id)}
  end

  def self.getRatings(statLines, min, max, weights)
  	statLines = statLines.map{|playerStats| playerStats.zip(min,max,weights)}.map{|row|row.map{|stat,minStat,maxStat,weight| (stat.to_f-minStat)/(maxStat-minStat)*weight}}
  	ratings = statLines.map{|playerStatLine| playerStatLine.sum}
  	ratings
  end

  def self.getLastNGamesStatLines(currentStatLines, oldStatLines, numGames)
  	lastNGamesStatLines = []

  	currentStatLines.zip(oldStatLines).map do |current, old|
  		lastNGamesStatLines.push(currentMinusNgames(current, old, numGames))
  	end
  	lastNGamesStatLines
  end

  def self.getTotalAdjusted(categories, numGames, weights)
  	currentStatLines = getCurrentStats(categories)
  	oldStatLines = getNGamesAgoStats(categories, numgames)

  	lastNGamesStatLines = getLastNGamesStatLines(currentStatLines, oldStatLines, numGames)
  	min = lastNGamesStatLines.transpose.map{|column| column.min}
  	max = lastNGamesStatLines.transpose.map{|column| column.max}
  	adjustedStatLines = lastNGamesStatLines.map{|playerStats| playerStats.zip(min,max)}.map{|row|row.map{|stat,minStat,maxStat| (stat.to_f-minStat)/(maxStat-minStat)}}
  	adjustedStatLines = adjustedStatLines.map{|playerStatLine| playerStatLine.push(playerStatLine.sum)}
  	adjustedStatLines = reinsertNamesGames(adjustedStatLines, currentStatLines, numGames)
  	adjustedStatLines.sort_by!{|statLine| -statLine[statLine.length-2]}
  end

  def self.getMin(lastNGamesStatLines, games_played)
  	min=[10000]*lastNGamesStatLines[0].length
  	games_played.length.times do |i|
  		if games_played[i]>5
  			lastNGamesStatLines[0].length.times.each do |j|
  				min[j]>lastNGamesStatLines[i][j] ? min[j] = lastNGamesStatLines[i][j] : min[j]
  			end
  		end
  	end
  	min
  end

  def self.getMax(lastNGamesStatLines, games_played)
  	max=[-10000]*lastNGamesStatLines[0].length
  	games_played.length.times.each do |i|
  		if games_played[i]>5
  			lastNGamesStatLines[0].length.times.each do |j|
  				max[j]<lastNGamesStatLines[i][j] ? max[j] = lastNGamesStatLines[i][j] : max[j]
  			end
  		end
  	end
  	max
  end

  def self.fillOutOldStats(currentStatLines, incompleteOldStatLines)
    incompleteOldStatLines = nil ? num_old=0 : num_old=incompleteOldStatLines.length
    completeOldStatLines=[]
    num_missing=0
    currentStatLines.length.times do |i|
      if i>num_old or currentStatLines[i][1]!=incompleteOldStatLines[i-num_missing][1]
        completeOldStatLines<<currentStatLines[i].slice(0,2)+[0]*(currentStatLines[i].length-2)
        num_missing+=1
      else
        completeOldStatLines<<incompleteOldStatLines[i-num_missing]
      end
    end
    completeOldStatLines
  end

  def self.getTotal(categories, numGames, weights)
  	currentStatLines = getCurrentStats(categories)
  	incompleteOldStatLines = getNGamesAgoStats(categories, numGames)

    oldStatLines = fillOutOldStats(currentStatLines, incompleteOldStatLines)
  	lastNGamesStatLines = getLastNGamesStatLines(currentStatLines, oldStatLines, numGames)

  	games_played = currentStatLines.map{|player| [player[2]+1,numGames].min}
  	min = getMin(lastNGamesStatLines, games_played)
  	max = getMax(lastNGamesStatLines, games_played)

  	ratings=getRatings(lastNGamesStatLines, min, max, weights)
  	lastNGamesStatLines.zip(ratings).map{|statLine, rating| statLine.push(rating)}

  	lastNGamesStatLines=reinsertNamesGames(lastNGamesStatLines, currentStatLines, numGames)
  	lastNGamesStatLines.sort_by!{|statLine| -statLine[statLine.length-2]}

  end

  def self.getAverage(categories,numGames, weights)
  	currentStatLines = getCurrentStats(categories)
  	#oldStatLines = getNGamesAgoStats(categories, numGames)
  	games_played = currentStatLines.map{|player| [player[:games_played]+1,numGames].min}
  	#lastNGamesStatLines = getLastNGamesStatLines(currentStatLines, oldStatLines, numGames)
  	lastNGamesStatLines=currentStatLines
  	lastNGamesStatLines=lastNGamesStatLines.zip(games_played).map{|statLine,games| statLine.map{|stat| (stat.to_f*81/games)}}
  	min = lastNGamesStatLines.transpose.map{|column| column.min}
  	max = lastNGamesStatLines.transpose.map{|column| column.max}
  	min = getMin(lastNGamesStatLines, games_played)
  	max = getMax(lastNGamesStatLines, games_played)
  	ratings=getRatings(lastNGamesStatLines, min, max, weights)
  	lastNGamesStatLines.map!{|player| player.map{|stat| stat.round(0)}}
  	lastNGamesStatLines.zip(ratings).map{|statLine, rating| statLine.push(rating)}
  	lastNGamesStatLines=reinsertNamesGames(lastNGamesStatLines, currentStatLines, numGames)
  	lastNGamesStatLines.sort_by!{|statLine| -statLine[statLine.length-2]}
  end

  def self.getAverageAdjusted(categories, numgames, weights)
  	currentStatLines = getCurrentStats(categories)
  	oldStatLines = getNGamesAgoStats(categories, numgames)
  	games_played = currentStatLines.map{|player| player[:games_played]+1}

  	lastNGamesStatLines=lastNGamesStatLines.zip(games_played).map{|statLine,games| statLine.map{|stat| (stat.to_f*81/games)}}

  	min = lastNGamesStatLines.transpose.map{|column| column.min}
  	max = lastNGamesStatLines.transpose.map{|column| column.max}

  	adjustedStatLines = lastNGamesStatLines.map{|playerStats| playerStats.zip(min,max)}.map{|row|row.map{|stat,minStat,maxStat| ((stat.to_f-minStat)/(maxStat-minStat)).round(2)}}
  	adjustedStatLines = adjustedStatLines.zip(currentStatLines).map{|playerStatLine,current| playerStatLine.push(playerStatLine.sum/(current[:games_played]+1))}
  	adjustedStatLines = reinsertNamesGames(adjustedStatLines, currentStatLines, numGames)
  	adjustedStatLines.sort_by!{|statLine| -statLine[statLine.length-1]}
  end

end
