class Plan < ApplicationRecord
  validates :lessondate, presence: true
  validates :goal, presence: true, length:{in:1..50}
  validates :item, presence: true
  validates :content, presence: true
  belongs_to :user

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      # Plan.where(['name LIKE ?', "%#{search}%"])
      Plan.where(['item LIKE ?', "%#{search}%"])
    else
      Plan.all #全て表示。
    end
  end
end
