require 'rails_helper'

RSpec.describe Currency, type: :model do
  describe "validations" do
    subject { build(:currency) }

    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_length_of(:code).is_equal_to(3) }
    it { is_expected.to allow_value("RSD", "EUR").for(:code) }
    it { is_expected.not_to allow_value("RS", "RSDD", "12r", "").for(:code) }
    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
    it { is_expected.to allow_value(true, false).for(:is_default) }
  end

  describe "callbacks" do
    it "uppercases the code before validation" do
      currency = build(:currency, code: "usd")
      currency.validate
      expect(currency.code).to eq("USD")
    end

    it "ensures only one default currency" do
      create(:currency, :default, code: "USD")
      eur = create(:currency, :default, code: "EUR")

      expect(eur.reload.is_default).to be true
      expect(Currency.find_by(code: "USD").is_default).to be false
    end
  end
end
