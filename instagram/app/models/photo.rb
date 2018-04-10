class Photo < ApplicationRecord
  validates :author_id, presence: true

  has_attached_file :img_url, default_url: "img_not_found.png"
  validates_attachment_content_type :img_url, content_type: /\Aimage\/.*\Z/

  belongs_to :author,
    class_name: :User,
    foreign_key: :author_id

  has_many :likes

  def like_count
    self.likes.count
  end

end
