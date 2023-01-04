class Reservation < ApplicationRecord
    belongs_to :sheet
    belongs_to :schedule

    validates :sheet_id, uniqueness: { scope: :schedule_id, message: "その座席はすでに予約済みです。" }
    validates :name, presence: { message: "氏名の指定は必須です。" }
    validates :email, presence: { message: "メールアドレスの指定は必須です。" }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "メールアドレスが無効です。" }
end
