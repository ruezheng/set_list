class Song < ApplicationRecord
  belongs_to :artist

  def self.play_count_above(threshold)
    where("play_count > #{threshold}").count
  end

  def self.shortest_two
     order('length asc').limit(2)
  end
end
