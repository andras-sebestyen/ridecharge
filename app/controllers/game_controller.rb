class GameController < ApplicationController
	layout 'application'
	def index
	end

	def create
	end

	def play
		player_choice = params[:choice].to_sym
		@curb_choice = Curb.choice.to_sym || Game.random_throw
		@player_message, @curb_message = case Game.decide_winner(player_choice, @curb_choice)
		when :draw
			["You drew!", "Curb with #{@curb_choice} drew"]
		when :player1
			["You won!", "Curb with #{@curb_choice} lost"]
		when :player2
			["You lost!", "Curb with #{@curb_choice} won"]
		end
	end
end
