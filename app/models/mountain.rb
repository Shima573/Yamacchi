class Mountain < ApplicationRecord
  # 保存前に生のグレーディング情報を正規化スコアに変換する
  before_save :set_normalized_scores

  enum :raw_technical_grade, { A: 0, B: 1, C: 2, D: 3, E: 4 }, prefix: :grade

  THRESHOLD = 15

  # 技術度ランクを数値スコアに変換するためのマッピング
  def technical_rank_score
    self.class.raw_technical_grades[raw_technical_grade] + 1
  end

  def self.recommend_for(diagnosis)
    # ユーザーの体力レベル
    target_score = diagnosis.target_physical_score

    # メインの検索
    mountains = where(normalized_technical_score: ..diagnosis.recommended_technical_max)
                .order(normalized_physical_score: :desc)
                .limit(20)
                .to_a

    perfect = []
    easy = []
    challenge = []

    # 山を「おすすめの種類ごと」に仕分けしている処理
    mountains.each do |mountain|
      case mountain.recommendation_type(diagnosis)
      when :perfect
        perfect << mountain
      when :easy
        easy << mountain
      when :challenge
        challenge << mountain
      end
    end

    result = []
    result += perfect.first(2)
    result += easy.first(3 - result.size) if result.size < 3
    result += challenge.first(3 - result.size) if result.size < 3

    result
  end

  def recommendation_type(diagnosis)
    # ユーザーの体力レベル
    target_score = diagnosis.target_physical_score

    # 差分計算
    difference = self.normalized_physical_score - target_score
    # 条件分岐
    if difference.abs <= THRESHOLD
      :perfect
    elsif difference < 0
      :easy
    else
      :challenge
    end
  end

  private

  # rawデータを元に正規化スコアを算出するロジック
  def set_normalized_scores
    # 体力度: 1-10 の数値を 10-100 のスコアに変換
    self.normalized_physical_score = raw_physical_grade * 10 if raw_physical_grade.present?

    # 技術度: enumの定義順を利用して 1-5 の数値に変換
    if raw_technical_grade.present?
      self.normalized_technical_score = technical_rank_score
    end
  end
end
