class Dish < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :tips, length: { maximum: 50 }
  validates :popularity,
            :numericality => {
              :only_interger => true,
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5
            },
            allow_nil: true
  validate  :picture_size

  # 料理に付属するコメントのフィードを作成
  def feed_comment(dish_id)
    Comment.where("dish_id = ?", dish_id)
  end

  private

  # アップロードされた画像のサイズを制限する
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
    end
  end
end
