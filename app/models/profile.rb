class Profile < ApplicationRecord
  attributes :id, :image
  has_one_attached :image
  belongs_to :donor, class_name: 'User'

  def image_path
    Rails.env.test? ? ActiveStorage::Blob.service.path_for(image.key) : image.service_url(expires_in: 1.hour, disposition: 'inline')
  end
end
