module MountainsHelper
  def toilet_label(mountain)
    mountain.has_toilet ? "あり" : "なし"
  end

  def mountain_image(mountain)
    mountain.image_url.presence || "sample/placeholder-mountain.jpg"
  end
end
