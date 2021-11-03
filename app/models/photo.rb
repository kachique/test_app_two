class Photo < ApplicationRecord
  enum license: [:copyright, :copyleft, :creative_comons]
  enum visibility:[:pub, :priv]
  belongs_to :user
end
