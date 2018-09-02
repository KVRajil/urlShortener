class Url < ApplicationRecord
  before_validation :set_token, on: :create
  before_validation :add_url_protocol
  validates :original_url,  :presence => true
  validates :shortened_url, :presence => true, :uniqueness => true
  validates_format_of :original_url, :with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix

  belongs_to :user

  scope :active, -> { where(:is_deleted => false) }

  def generate_unique_token
    token = generate_token
    if Url.where(shortened_url:token).count > 0
      generate_unique_token
    else
      return token
    end
  end

  def generate_token
    (0...10).map { (('A'..'Z').to_a+('a'..'z').to_a+(2..9).to_a-['O','I'])[rand(58)] }.join
  end

  private
    def set_token
      self.shortened_url = generate_unique_token
    end

  def add_url_protocol
    unless self.original_url[/\Ahttp:\/\//] || self.original_url[/\Ahttps:\/\//]
      self.original_url = "http://#{self.original_url}"
    end
  end

end
