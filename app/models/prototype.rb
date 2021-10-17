class Prototype < ApplicationRecord
  # prototypesテーブルのレコードが削除された場合、関連しているcommentsも同時に削除
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
end
