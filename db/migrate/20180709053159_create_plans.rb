class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      # 教案ID	
      # t.integer :id
      # 実施日時	
      t.date :lessondate
      # 目標	
      t.string :goal
      # 項目	
      t.string :item
      # 活動	
      t.text :content
      # コメント	
      t.text :comment
      
      t.timestamps
    end
  end
end
