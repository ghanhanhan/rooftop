class Post < ActiveRecord::Base
    has_many :replies
    mount_uploader :cover_image, S3uploaderUploader
end
