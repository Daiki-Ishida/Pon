# 'PON' フェレットの飼い主のマッチングアプリケーション

近所のフェレットの飼い主、フェレット好きがフェレットとの生活を支援し合う場を提供するアプリです。

## フェレットとは

https://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A7%E3%83%AC%E3%83%83%E3%83%88

フェレットいわゆるイタチの仲間であり、まだまだマイナーであるもののペットとして飼育している人も多い動物です。

## アプリの趣旨

フェレットには以下のような特徴があります。

* 大きな声を出さない。
* 散歩の必要性がない。
* １日の大半は寝ている（２０時間くらい寝る時もある）。
* 餌は、適量を皿に入れておけば、必要な分だけ勝手に食べる（ある程度は放置できる）。

このようなことから、都市部、一人暮らしでも比較的飼育しやすいとも言えます。また、一般的なペットショップでも販売されています。しかし、その一方でペットとしては依然としてマイナーな存在で、イヌやネコなどと比較するとペットホテルや病院の数が圧倒的に少ないのが実情です。

例えば一人暮らしでフェレットを飼育し、出張などの長期間の外出の必要性が生じた場合に、預けられる知人が近所にいないと遠くのペットホテルまでフェレットを預けに行かなければいけない可能性もあります。

そのような状況で、フェレットを飼育している人どうしがフェレットとの生活において協力しあえるような場を提供すべく、本アプリを作成しました。もちろん、現在はフェレットを飼育していないものの、将来的に飼育してみたい、あるいは過去の飼育していた、という人もユーザーとして想定しています。

## アプリの機能

本アプリの機能の一連の流れとしては以下の通りです。

* ユーザー登録、フェレットを飼育している人はフェレットも登録。
* フェレットを預けたい人はお世話係の募集、フェレットを預かりたい人はお世話係への立候補が可能。（任意）
* アプリ内のメッセージ機能等を通して、双方の信頼関係を築け、都合が合えば、飼い主側からお世話係候補へアプリ内のフォームからお世話の依頼を提出。
* お世話係の候補側が依頼を承認すれば、契約成立。お世話に祭して、お世話係は飼い主に対してレポートを提出。飼い主はお世話終了後、レビューの作成。
* 謝礼やレポートの頻度、内容等は当事者間で任意に決定。

## アプリの特徴(設計面)

- お世話の依頼やレポート等は作成されるたびに自動でアプリ内メッセージが相手に送付される。 
- アプリ内の一連の行動（メッセージの送付やいいね等）が行動の受け手に通知される。
- サービスの内容、使い方がわかりやすいように説明を随所に記載。
- エラーページの設定。

## アプリの特徴(開発面)

- 学習のためWebpack(Webpacker)を導入。将来的にはフロントをVue.js(or React)に置き換えてみたいと思い学習中。
- 制作にあたって参考にした記事（ https://techracho.bpsinc.jp/hachi8833/2017_12_26/49931 ）　

## この後の改善の予定

- 空リンクになっているヘルプ等の実装
- 問い合わせ機能、管理者機能実装
- スマホ対応
- minitestを書き進める。
- LINEログイン
  - 生き物の命に関わりかねないサービスであり、利用者の本人確認、特定をより確実に行う必要があるため。

# 製作者について

## 開発実績

DMM Webcamp 2019/5/1 ~ 2019/7/31

## 使用したことのある言語

* Ruby
* Ruby on Rails
* HTML/CSS
* Javascript

