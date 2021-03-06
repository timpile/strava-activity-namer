class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:strava]

  has_many :activities
  has_many :laps, through: :activities

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.token = auth.credentials.token
       # user.name = auth.info.name   # assuming the user model has a name
       # user.image = auth.info.image # assuming the user model has an image
     end
  end

  def strava_client
    @strava_client ||= Strava::Api::V3::Client.new(:access_token => self.token)
  end

  def last_activity_date
    activities.maximum(:start_date_local) || 3.years.ago
  end

end
