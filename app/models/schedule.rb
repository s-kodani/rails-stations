class Schedule < ApplicationRecord
    belongs_to :movie
    has_many :reservations

    def self.get_schedules(movie_id)
        return Schedule.where(movie_id: movie_id)
    end
end
