class ChangeOptionsToModel < ActiveRecord::Migration
  def change
  	remove_column :topics, :options, :text
  	add_column :topic_options, :topic_id, :integer
  	add_column :topic_options, :value, :string
  end
end
