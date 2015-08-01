class CreateTopicOptions < ActiveRecord::Migration
  def change
    create_table :topic_options do |t|
 
      t.timestamps null: false
    end
  end
end
