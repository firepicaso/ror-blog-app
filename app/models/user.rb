class User < ApplicationRecord
    has_many :post, foreign_key: 'author_id'
    has_many :comment
    has_many :like
end
