# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 既存データの削除
puts "Cleaning up database..."
Mountain.destroy_all

puts "Creating mountains based on Raw Data (Automatic normalization)..."

mountains_data = [
  {
    name: "高尾山",
    elevation: 599,
    prefecture: "東京都",
    latitude: 35.6251,
    longitude: 139.2437,
    raw_physical_grade: 1,      # これを元に normalized_physical_score が 10 になる
    raw_technical_grade: "A",   # これを元に normalized_technical_score が 1 になる
    grade_source_prefecture: "東京都",
    has_toilet: true,
    access_detail: "京王線高尾山口駅から徒歩すぐ。観光客も多く非常に登りやすい。",
    image_url: "https://placehold.jp/24/cccccc/ffffff/400x300.png?text=高尾山"
  },
  {
    name: "筑波山",
    elevation: 877,
    prefecture: "茨城県",
    latitude: 36.2253,
    longitude: 140.1067,
    raw_physical_grade: 2,      # -> normalized 20
    raw_technical_grade: "B",   # -> normalized 2
    grade_source_prefecture: "茨城県",
    has_toilet: true,
    access_detail: "つくばエクスプレスつくば駅からシャトルバス。岩場があり登りごたえがある。",
    image_url: "https://placehold.jp/24/cccccc/ffffff/400x300.png?text=筑波山"
  },
  {
    name: "槍ヶ岳",
    elevation: 3180,
    prefecture: "長野県",
    latitude: 36.3420,
    longitude: 137.6476,
    raw_physical_grade: 9,      # -> normalized 90
    raw_technical_grade: "D",   # -> normalized 4
    grade_source_prefecture: "長野県",
    has_toilet: true,
    access_detail: "北アルプスのシンボル。長い歩行距離と急峻な梯子・鎖場がある。",
    image_url: "https://placehold.jp/24/cccccc/ffffff/400x300.png?text=槍ヶ岳"
  }
]

mountains_data.each do |data|
  # normalized_... スコアを明示的に書かなくても、
  # 保存時(create!)にモデルの before_save が動いて自動計算されます
  Mountain.create!(data)
end

puts "Success: Created #{Mountain.count} mountains!"
