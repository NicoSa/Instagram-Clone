class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :likes
	has_attached_file :picture, styles: { medium: '300x300>' },
					  storage: :s3,
					  s3_credentials: {
					  	bucket: 'Instagram-Clone-Nico',
					  	access_key_id: Rails.application.secrets.s3_access_key,
					  	secret_access_key: Rails.application.secrets.s3_secret_key
					  }
	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
