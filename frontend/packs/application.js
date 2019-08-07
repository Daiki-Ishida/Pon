import "init";
import '@fortawesome/fontawesome-free/js/all';
import 'jquery/dist/jquery.js';

import 'raty-js'

import Rails from 'rails-ujs';
Rails.start()

// ５色のボーダー
import "components/colorful-border/colorful-border";

// 各種ボタン
import "components/edit-btn/edit-btn";
import "components/delete-btn/delete-btn";
import "components/follow/follow";

// 以下各ページのベースになるテンプレート
// 1.ランディングページのテンプレート
import "components/top/top";
// 2.一覧系以外のページのテンプレート
import "components/page/page";
// 3.一覧のテンプレート
import "components/home/home";
// 4.管理者ページテンプレート
import "components/admins-home/admins-home"
