class NewsletterSubscriber < ApplicationRecord
validates :email, presence: { message: "can't be blank!"}, uniqueness: { message: "already exist"}
validates :preferences, presence: { message: "can't be blank!"}
end
