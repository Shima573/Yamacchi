class Diagnosis < ApplicationRecord
  belongs_to :user, optional: true

  # 質問回答からDiagnosisのインスタンスを生成するクラスメソッド
  def self.build_from_answers(params)
    q1 = params[:q1].to_i
    q2 = params[:q2].to_i
    q3 = params[:q3].to_i
    q4 = params[:q4].to_i
    q5 = params[:q5].to_i

    # 体力計算
    physical_total = q1 + q2 + q3
    physical_grade = ((physical_total - 3) / 12.0 * 9 + 1).round

    # 技術計算
    technical_total = q4 + q5
    technical_grade = case technical_total
    when 2..4  then 1 # A相当
    when 5..7  then 2 # B相当
    when 8     then 3 # C相当
    when 9     then 4 # D相当
    when 10    then 5 # E相当
    else 1
    end

    # Diagnosisオブジェクトの作成
    new(
      total_score: (physical_total + technical_total),
      recommended_physical_min: [ (physical_grade - 1), 1 ].max,
      recommended_physical_max: [ (physical_grade + 1), 10 ].min,
      recommended_technical_max: technical_grade
    )
  end

  # ユーザーの体力レベル（1〜10）を10倍してスコア（10〜100）に変換
  def target_physical_score
    # minとmaxから計算
    (recommended_physical_min + recommended_physical_max) * 5
  end
end
