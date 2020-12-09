class Song < ApplicationRecord
  belongs_to :artist

  def self.play_count_above(threshold)
    where("play_count > #{threshold}").count
  end

  def self.shortest_two
     order('length asc')
     .limit(2)
  end

  def self.random_song
    order('Random()')
    .limit(1)
    .first
  end

  def self.all_ids
    pluck(:id)
  end

  def self.artist_name_by_song_id(ids)
    Artist.where(id: self.where(id: ids).pluck(:artist_id))
          .pluck(:name)
  end

  def self.most_played
    order('play_count DESC')
    .limit(1)
    .first
  end

  def artist_name
    artist.name
  end
end
