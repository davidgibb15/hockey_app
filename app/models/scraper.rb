require 'nokogiri'
require 'open-uri'
require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'csv'
games=[]
startDate=Date.new(2017,01,01)
endDate=Date.new(2017,04,10)
include Capybara::DSL
session = Capybara::Session.new(:poltergeist)


#skater summary
ssgames=[]
session.visit "http://www.nhl.com/stats/player?aggregate=0&gameType=2&report=skatersummary&pos=S&reportType=game&startDate=#{startDate}&endDate=#{endDate}&filter=gamesPlayed,gte,1&sort=points,goals,assists"
sleep(2)
session.all("th[class='extra-wide left']")[0].click
sleep(2)
pages=session.find('.pager-select').all('option').collect(&:text)
(0..pages.length-1).each do |num|
	sleep(0.25)
	session.find('.pager-select').find("option[value='#{num}']").select_option
	rows=session.all("tr.standard-row")
	rows.each do |row|
		text=row.text.split(" ")
		if text.length==25
			text[1]="#{text[1]} #{text[2]}"
			text.delete_at(2)
		elsif text.length ==26
			text[1]="#{text[1]} #{text[2]} #{text[3]}"
			text.delete_at(2)
			text.delete_at(2)
		elsif text.length ==27
			text[1]="#{text[1]} #{text[2]} #{text[3]} #{text[4]}"
			text.delete_at(2)
			text.delete_at(2)
			text.delete_at(2)
		else 
			puts text
		end
		dateArr=text[4].split("/")
		date=Date.new(dateArr[0].to_i,dateArr[1].to_i,dateArr[2].to_i)
		text[4]=date
		text[22]=text[22].to_i

		name=text[1]
		team=text[2]
		pos=text[3]
		date=text[4]
		home=!text[5]=="@"
		against=text[6]
		goals=text[8].to_i
		assists=text[9].to_i
		pm=text[11].to_i
		pim=text[12].to_i
		ppg=text[13].to_i
		ppa=text[14].to_i-ppg
		shg=text[15].to_i
		sha=text[16].to_i-shg
		gwg=text[17].to_i
		otg=text[18].to_i
		s=text[19].to_i
		sp=text[20].to_f
		toi_raw=text[21].split(":")
		toi=toi_raw[0].to_i*60+toi_raw[1].to_i
		shifts=text[22]
		ssgames.push([name,team,pos,date,home,against,goals,assists,pm,pim,ppg,ppa,shg,sha,gwg,otg,s,sp,toi,shifts])
	end
end
puts ssgames
hbgames=[]
session.visit "http://www.nhl.com/stats/player?aggregate=0&gameType=2&report=realtime&pos=S&reportType=game&startDate=#{startDate}&endDate=#{endDate}&filter=gamesPlayed,gte,&sort=hits"
sleep(2)
session.all("th[class='extra-wide left']")[0].click
sleep(2)
pages=session.find('.pager-select').all('option').collect(&:text)
(0..pages.length-1).each do |num|
	session.find('.pager-select').find("option[value='#{num}']").select_option
	rows=session.all("tr.standard-row")
	rows.each do |row|
		text=row.text.split(" ")
		if text.length==26
			text[1]="#{text[1]} #{text[2]}"
			text.delete_at(2)
		elsif text.length ==27
			text[1]="#{text[1]} #{text[2]} #{text[3]}"
			text.delete_at(2)
			text.delete_at(2)
		elsif text.length ==28
			text[1]="#{text[1]} #{text[2]} #{text[3]} #{text[4]}"
			text.delete_at(2)
			text.delete_at(2)
			text.delete_at(2)
		else
			puts text
		end
		hits=text[8].to_i
		blocks=text[10].to_i
		mss=text[12].to_i
		gva=text[14].to_i
		tka=text[15].to_i
		fow=text[17].to_i
		fol=text[18].to_i
		fop=text[19].to_i
		hbgames.push([hits,blocks,mss,gva,tka,fow,fol,fop])
	end
end
puts hbgames
igames=[]
CSV.open("igames2.csv","w") do |csv|
	(0..ssgames.length-1).each do |i|
		csv << ssgames[i]+hbgames[i]
	end
end