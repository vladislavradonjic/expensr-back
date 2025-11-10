class Currency < ApplicationRecord
  validates :code, presence: true, length: { is: 3 },
            format: { with: /\A[A-Z]{3}\z/ },
            uniqueness: { case_sensitive: false }
  validates :is_default, inclusion: { in: [true, false] }

  before_validation :normalize_code
  after_commit :ensure_single_default, if: -> { is_default? && saved_change_to_is_default? }

  private

  def normalize_code
    self.code = code&.upcase
  end

  def ensure_single_default
    self.class.where.not(id: id).update_all(is_default: false)
  end
end
