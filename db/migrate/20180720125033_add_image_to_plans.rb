class AddImageToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :image, :text
  end
end
