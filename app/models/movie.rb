class Movie < ApplicationRecord
    validates :id, uniqueness: { message: "IDが重複しています。" }
    validates :year, presence: { message: "公開年の指定は必須です。" }
    validates :description, presence: { message: "概要の記載は必須です。" }
    validates :name, presence: { message: "タイトルの指定は必須です。" }, uniqueness: { message: "タイトルが重複しています。" }, length: { maximum: 160, message: "タイトルは160文字以内で記載してください。" }
    validates :image_url, presence: { message: "画像URLの指定は必須です。" }, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "URLの形式が不正です。" }
    validates :created_at, presence: { message: "登録日時の指定は必須です。" }
    validates :updated_at, presence: { message: "更新日時の指定は必須です。" }
end
