class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable

 has_many :listings
 has_many :reservations

 has_attached_file :image, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "avator-default.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

 def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.image = "http://graph.facebook.com/#{auth.uid}/picture?type=large"
 # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end

def connected?
  !stripe_user_id.nil?
end
end
