class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount, optional: true
  belongs_to :address, optional: true
  has_many :order_details, dependent: :destroy
  has_many :book_details, ->{with_deleted}, through: :order_details
  enum status: {pending: 0, accepted: 1, rejected: 2}, _suffix: true
  delegate :name, to: :user, prefix: true, allow_nil: true
  scope :order_newest, ->{order(created_at: :desc)}

  accepts_nested_attributes_for :order_details, allow_destroy: true

  def send_mail_approve
    ApproveOrderJob.set(wait: Settings.number_15.seconds).perform_later self
  end

  def send_mail_reject
    RejectOrderJob.set(wait: Settings.number_15.seconds).perform_later self
  end

  class << self
    def convert_vnd price, locale
      return price if locale == "en"

      price * Settings.dollar_to_vnd
    end
  end
end
