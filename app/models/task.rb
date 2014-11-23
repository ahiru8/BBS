class Task < ActiveRecord::Base
	belongs_to :project
	has_and_belongs_to_many :tags
	validates :title, presence: true
	scope :unfinished, -> { where(done: false) }
end
