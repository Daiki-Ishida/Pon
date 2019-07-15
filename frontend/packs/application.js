import "init";
import '@fortawesome/fontawesome-free/js/all';
import Rails from 'rails-ujs'
Rails.start()

// ５色のボーダー
import "components/colorful-border/colorful-border";

// 各種ボタン
import "components/edit-btn/edit-btn";
import "components/delete-btn/delete-btn";
import "components/follow/follow"

// ヘッダー・フッター
import "components/header/header";
// import "componetns/footer/footer";

// 以下各ページのベースになるページ
// 1.ランディングページのベース
import "components/top/top";
// 2.一覧系以外のページのベース
import "components/page/page";
// 3.フェレット・ユーザー一覧のベース
import "components/home/home";
// 4.投稿一覧のベース
import "components/posts/posts";
