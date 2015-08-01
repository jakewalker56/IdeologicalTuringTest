class ChangeValueToTopicOptionIdInVotes < ActiveRecord::Migration
  def change
  	remove_column :votes, :value, :string

  	add_column :votes, :overall_vote_id, :integer
  end
end
