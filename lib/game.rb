module Game
	THROW_RULES = { rock: [:scissors], scissors: [:paper], paper: [:rock] }.freeze
	THROWS = THROW_RULES.keys.freeze

	def self.random_throw
		THROWS[rand(THROWS.count)]
	end

	def self.decide_winner(throw1, throw2)
		if throw1 == throw2
			return :draw
		elsif THROW_RULES[throw1].include? throw2
			return :player1
		else
			return :player2
		end
	end
end