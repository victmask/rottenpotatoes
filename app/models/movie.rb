class Movie < ActiveRecord::Base
  def self.get_ratings
    all.map {|movie| movie.rating}.uniq
  end
end
