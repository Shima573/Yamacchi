module MountainsHelper
  def toilet_label(mountain)
    mountain.has_toilet ? "あり" : "なし"
  end
end
