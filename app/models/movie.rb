class Movie < ActiveRecord::Base
	@@ratings = {'G'=>1,'PG'=>1,'PG-13'=>1,'R'=>1,'NC-17'=>1}
	def self.ratings
		@@ratings
	end
end
