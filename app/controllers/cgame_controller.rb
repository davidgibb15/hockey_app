class CgameController < ApplicationController
	@stats
	def index
		@categories=[:name]
		weights=[]
		@categories.push(:games_played)
		@goals=false
		if params[:goals]
			@goals=true
			@categories.push(:goals)
			weights.push(params[:goals_weight].to_f)
		end
		@assists=false
		if params[:assists]
			@assists=true
			@categories.push(:assists)
			weights.push(params[:assists_weight].to_f)
		end
		@points=false
		if params[:points]
			@points=true
			@categories.push(:points)
			weights.push(params[:points_weight].to_f)
		end
		@p_m=false
		if params[:'+-']
			@p_m=true
			@categories.push(:plus_minus)
			weights.push(params[:'+-_weight'].to_f)
		end
		@pim=false
		if params[:pim]
			@pim=true
			@categories.push(:pim)
			weights.push(params[:pim_weight].to_f)
		end
		@ppg=false
		if params[:ppg]
			@ppg=true
			@categories.push(:ppg)
			weights.push(params[:ppg_weight].to_f)
		end
		@ppa=false
		if params[:ppa]
			@ppa=true
			@categories.push(:ppa)
			weights.push(params[:ppa_weight].to_f)
		end
		@ppp=false
		if params[:ppp]
			@ppp=true
			@categories.push(:ppp)
			weights.push(params[:ppp_weight].to_f)
		end
		@shg=false
		if params[:shg]
			@shg=true
			@categories.push(:shg)
			weights.push(params[:shg_weight].to_f)
		end
		@sha=false
		if params[:sha]
			@sha=true
			@categories.push(:sha)
			weights.push(params[:sha_weight].to_f)
		end
		@shp=false
		if params[:shp]
			@shp=true
			@categories.push(:shp)
			weights.push(params[:shp_weight].to_f)
		end
		@gwg=false
		if params[:gwg]
			@gwg=true
			@categories.push(:gwg)
			weights.push(params[:gwg_weight].to_f)
		end
		@otg=false
		if params[:otg]
			@otg=true
			@categories.push(:otg)
			weights.push(params[:otg_weight].to_f)
		end
		@shots=false
		if params[:shots]
			@shots=true
			@categories.push(:shots)
			weights.push(params[:shots_weight].to_f)
		end
		@toi=false
		if params[:toi]
			@toi=true
			@categories.push(:toi)
			weights.push(params[:toi_weight].to_f)
		end
		@shifts=false
		if params[:shifts]
			@shifts=true
			@categories.push(:shifts)
			weights.push(params[:shifts_weight].to_f)
		end
		@hits=false
		if params[:hits]
			@hits=true
			@categories.push(:hits)
			weights.push(params[:hits_weight].to_f)
		end
		@blocks=false
		if params[:blocks]
			@blocks=true
			@categories.push(:blocks)
			weights.push(params[:blocks_weight].to_f)
		end
		@mss=false
		if params[:mss]
			@mss=true
			@categories.push(:mss)
			weights.push(params[:mss_weight].to_f)
		end
		@gva=false
		if params[:gva]
			@gva=true
			@categories.push(:gva)
			weights.push(params[:gva_weight].to_f)
		end
		@tka=false
		if params[:tka]
			@tka=true
			@categories.push(:tka)
			weights.push(params[:tka_weight].to_f)
		end
		@fo=false
		if params[:fo]
			@fo=true
			@categories.push(:fo)
			weights.push(params[:fo_weight].to_f)
		end
		@fow=false
		if params[:fow]
			@fow=true
			@categories.push(:fow)
			weights.push(params[:fow_weight].to_f)
		end
		@fol=false
		if params[:fol]
			@fol=true
			@categories.push(:fol)
			weights.push(params[:fol_weight].to_f)
		end
		@numGames=params[:last_n_games]
		if @numGames == "" || @numGames== nil
			@numGames=100
		end
		weights.map!{|w| w==0 ? w=1 : w}
		@stats=Cgame.getAverage(@categories,@numGames.to_i, weights)
	end
end
