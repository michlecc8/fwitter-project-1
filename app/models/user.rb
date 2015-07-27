class User < ActiveRecord::Base
  has_many :tweets
#   attr_accessor :name, :email
  
#   ALL_USERS = []
  
#   def initialize(name, email)
#     @name = name
#     @email = email
#     ALL_USERS << self
#   end
  
#   def self.all
#     ALL_USERS
#   end
  
end