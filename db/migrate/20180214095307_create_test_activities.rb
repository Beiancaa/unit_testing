class CreateTestActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :test_activities do |t|
      t.string :activity_url
      t.string :status
      t.integer :client_id
      t.integer :case_id
      t.string :created_by
      t.string :activity_type
      t.string :activity_code
      t.string :description
      t.integer :environment_id
      
      t.timestamps
    end
  end
end
