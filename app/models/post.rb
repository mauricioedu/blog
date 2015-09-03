class Post < ActiveRecord::Base
	acts_as_votable
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence:true, length: {minimum: 5}
	validates :body, presence:true
end
