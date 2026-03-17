class Mountain < ApplicationRecord
  # 保存前に生のグレーディング情報を正規化スコアに変換する
  before_save :set_normalized_scores

  enum :raw_technical_grade, { A: 0, B: 1, C: 2, D: 3, E: 4 }, prefix: :grade

  # 技術度ランクを数値スコアに変換するためのマッピング
  def technical_rank_score
    self.class.raw_technical_grades[raw_technical_grade] + 1
  end

  def self.recommend_for(diagnosis)
    # ユーザーの体力レベル（1〜10）を10倍してスコア（10〜100）に変換
    target_score = (diagnosis.recommended_physical_min + diagnosis.recommended_physical_max) * 5

    # メインの検索
    mountains = where(normalized_technical_score: ..diagnosis.recommended_technical_max)
                .where(normalized_physical_score: (target_score - 15)..(target_score + 15))
                .order(normalized_physical_score: :desc)
                .limit(3)
                .to_a

    # 補充ロジック
    if mountains.size < 3
      additional = where(normalized_technical_score: ..diagnosis.recommended_technical_max)
                    .where.not(id: mountains.map(&:id))
                    .order(Arel.sql('RANDOM()'))
                    .limit(3 - mountains.size)
      mountains += additional.to_a
    end

    mountains
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
