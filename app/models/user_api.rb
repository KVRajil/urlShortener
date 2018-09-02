class UserApi < ApplicationRecord
  validates :user_id,  :presence => true

  belongs_to :user

  before_create :set_key

  def set_key
    self.key = generate_uniq_key
  end

  def generate_uniq_key
    key = generate_key
    if UserApi.where(key:key).count > 0
      generate_key
    else
      return key
    end
  end

  def generate_key
    (0...20).map { (('A'..'Z').to_a+('a'..'z').to_a+(2..9).to_a-['O','I'])[rand(58)] }.join
  end

end
