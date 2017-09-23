require 'csv'
games=CSV.read('alligames.csv')
games.sort_by!{|game| game[3]}
cumulativeGames=[]
(0..81).each do
cumulativeGames.push([])
end

Player.all.to_a.each do |p|
lg=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
i=0
games.each do |g|
if g[0] == p.name
zero=g[0]
one=g[1]
two=g[2]
three=g[3]
four=g[4]
five=g[5]
six=g[6].to_i+lg[6]
seven=g[7].to_i+lg[7]
eight=g[8].to_i+lg[8]
nine=g[9].to_i+lg[9]
ten=g[10].to_i+lg[10]
eleven=g[11].to_i+lg[11]
twelve=g[12].to_i+lg[12]
thirteen=g[13].to_i+lg[13]
fourteen=g[14].to_i+lg[14]
fifteen=g[15].to_i+lg[15]
sixteen=g[16].to_i+lg[16]
seventeen=g[17].to_i+lg[17]
eighteen=g[18].to_i+lg[18]
nineteen=g[19].to_i+lg[19]
twenty=g[20].to_i+lg[20]
tone=g[21].to_i+lg[21]
ttwo=g[22].to_i+lg[22]
tthree=g[23].to_i+lg[23]
tfour=g[24].to_i+lg[24]
tfive=g[25].to_i+lg[25]
tsix=g[26].to_i+lg[26]
ng=[zero,one,two,three,four,five,six,seven,eight,nine,
	ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen,eighteen,nineteen,
	twenty,tone,ttwo,tthree,tfour,tfive,tsix]
cumulativeGames[i].push(ng)
lg[6]=six
lg[7]=seven
lg[8]=eight
lg[9]=nine
lg[10]=ten
lg[11]=eleven
lg[12]=twelve
lg[13]=thirteen
lg[14]=fourteen
lg[15]=fifteen
lg[16]=sixteen
lg[17]=seventeen
lg[18]=eighteen
lg[19]=nineteen
lg[20]=twenty
lg[21]=tone
lg[22]=ttwo
lg[23]=tthree
lg[24]=tfour
lg[25]=tfive
lg[26]=tsix
i=i+1

end
end
end
(0..81).each do |i|
CSV.open("cgames/cGames#{i}","w") do |csv|
(0..cumulativeGames[i].length-1).each do |j|
csv<<cumulativeGames[i][j]
end
end
end


#games.each do |game|
#	CSV.open("igames2.csv","w") do |csv|
#		(0..ssgames.length-1).each do |i|
#		csv << ssgames[i]+hbgames[i]
#	end
#end
#end
