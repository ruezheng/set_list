class Song < ApplicationRecord
  belongs_to :artist

  def self.play_count_above(threshold)
    where("play_count > #{threshold}").count
  end

  def self.by_title
    self.order('lower(title)')
  end

  def self.shortest(limit = 1)
    self.order(:length).limit(limit)
  end

  def artist_name
    self.artist.name
  end

  def self.love_songs
    self.where("title ilike '%love%'")
  end

  def self.three_most_played_with_a_length_updated_recently(length:)
    three_days_ago = Time.now - 3.days
    self.where('length > ?', length).where('updated_at > ?', three_days_ago).order(play_count: :desc).limit(3)
  end
end
