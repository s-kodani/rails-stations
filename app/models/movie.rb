class Movie < ApplicationRecord
    has_many :schedules

    validates :id, uniqueness: { message: "IDが重複しています。" }
    validates :year, presence: { message: "公開年の指定は必須です。" }
    validates :description, presence: { message: "概要の記載は必須です。" }
    validates :name, presence: { message: "タイトルの指定は必須です。" }, uniqueness: { message: "タイトルが重複しています。" }, length: { maximum: 160, message: "タイトルは160文字以内で記載してください。" }
    validates :image_url, presence: { message: "画像URLの指定は必須です。" }, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "URLの形式が不正です。" }

    def self.search_movies(keyword, is_showing)
        if keyword == nil && (is_showing == nil || is_showing == "all") then
            # 全件表示
            return Movie.all
        elsif keyword == nil then
            # 公開中ステータスを指定して検索表示
            return Movie.where('is_showing = (?)', is_showing)
        elsif is_showing == "all" || is_showing == nil then
            # フリーワードを指定して検索表示
            like_keyword = '%'.concat(keyword).concat('%')
            return Movie.where('name LIKE (?) OR description LIKE (?)', like_keyword, like_keyword)
        else
            # 公開中ステータス＆フリーワードを指定して検索表示
            like_keyword = '%'.concat(keyword).concat('%')
            return Movie.where('is_showing = (?) AND (name LIKE (?) OR description LIKE (?))', is_showing, keyword, like_keyword)
        end
    end
end
