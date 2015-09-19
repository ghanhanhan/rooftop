class Post < ActiveRecord::Base
    has_many :replies
    mount_uploader :file, S3uploaderUploader
end
