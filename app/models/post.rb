class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :likes
  has_and_belongs_to_many :tags

  has_attached_file :picture, styles: { medium: '300x300>' },
    storage: :s3,
  s3_credentials: {
    bucket: 'Instagram-Clone-Nico',
    access_key_id: Rails.application.secrets.s3_access_key,
    secret_access_key: Rails.application.secrets.s3_secret_key
  }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  def tag_names
    ''
  end

  def tag_names=(tag_names)
    return if tag_names.blank?
    tag_names.split(', ').uniq.each do |tag_name|
      tag = Tag.find_or_create_by(name: '#' + tag_name.delete('#'))
      self.tags << tag
    end
  end
end
