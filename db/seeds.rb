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
    image_url: "https://res.cloudinary.com/ds1c7hp4c/image/upload/v1775450915/%E9%AB%98%E5%B0%BE%E5%B1%B1_obfsn8.jpg"
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
    image_url: "https://res.cloudinary.com/ds1c7hp4c/image/upload/v1775456391/%E7%AD%91%E6%B3%A2%E5%B1%B1_r4zucm.jpg"
  },
  {
    name: "月山",
    elevation: 1984,
    prefecture: "山形県",
    latitude: 38.3256,
    longitude: 140.0137,
    raw_physical_grade: 3,
    raw_technical_grade: "A",
    grade_source_prefecture: "山形県",
    has_toilet: true,
    access_detail: "バス：西川町営バス姥沢バス停、または庄内交通月山八合目バス停",
    image_url: "https://res.cloudinary.com/ds1c7hp4c/image/upload/v1775454870/%E6%9C%88%E5%B1%B1_z9hiuh.jpg"
  },
  {
    name: "陣場山",
    elevation: 854,
    prefecture: "神奈川県",
    latitude: 35.3908,
    longitude: 139.1000,
    raw_physical_grade: 2,
    raw_technical_grade: "A",
    grade_source_prefecture: "神奈川県",
    has_toilet: true,
    access_detail: "JR高尾駅から「陣馬高原下」行きバス、またはJR藤野駅から「陣馬登山口」行きバスを利用してアクセスできます",
    image_url: "https://res.cloudinary.com/ds1c7hp4c/image/upload/v1775454880/%E9%99%A3%E5%A0%B4%E5%B1%B1_kfermj.jpg"
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
    image_url: "https://res.cloudinary.com/ds1c7hp4c/image/upload/v1775454887/%E6%A7%8D%E3%83%B6%E5%B2%B3_p5xh30.jpg"
  }
]

mountains_data.each do |data|
  # normalized_... スコアを明示的に書かなくても、
  # 保存時(create!)にモデルの before_save が動いて自動計算されます
  mountain = Mountain.find_or_initialize_by(name:data[:name])
  mountain.assign_attributes(data)
  mountain.save!
end

puts "Success: Created #{Mountain.count} mountains!"
