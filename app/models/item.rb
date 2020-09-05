class Item < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 400 }

  mount_uploader :image, ImageUploader
  
  validates :image, presence: true
  
  has_many :chats
end
