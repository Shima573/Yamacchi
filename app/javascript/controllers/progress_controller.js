import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress"
export default class extends Controller {
  connect() {
    const TOTAL = 5;

    // 内部関数：現在チェックが入っているラジオボタンの数を数える
    function getAnsweredCount() {
      let count = 0;
      for (let i = 1; i <= TOTAL; i++) {
        if (document.querySelector(`input[name="q${i}"]:checked`)) count++;
      }
      return count;
    }

    // 内部関数：画面上の数字やボタンの見た目を更新する
    function updateProgress() {
      const n = getAnsweredCount();

      document.getElementById('answered-count').textContent = `${n} / ${TOTAL} 問 回答済み`;

      const btn = document.getElementById('submit-btn');
      const lbl = document.getElementById('btn-label');

      if (n === TOTAL) {
        btn.disabled = false;
        btn.className = btn.className
          .replace('bg-gray-200 text-gray-400 cursor-not-allowed', '')
          + ' bg-dark text-white cursor-pointer hover:-translate-y-0.5 hover:bg-forest-dark shadow-lg shadow-forest/30';
        lbl.textContent = '診断結果を見る →';
      } else {
        lbl.textContent = `残り ${TOTAL - n} 問あります`;
      }
    }

    // イベントリスナー：画面内のすべてのラジオボタンを監視
    document.querySelectorAll('input[type="radio"]').forEach(r => {
      r.addEventListener('change', updateProgress);
    });
  }
}
