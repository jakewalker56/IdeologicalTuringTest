class TopicOption < ActiveRecord::Base
	has_many :submissions, foreign_key: :professed_topic_option_id
end
