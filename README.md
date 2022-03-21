# アプリケーション名
投句るうむ

# アプリケーション概要
『投句るうむ』は対戦型の俳句投稿サービスです。
投句期間: 写真と季節がセットのお題に対して、俳句を投稿することができます。
投票期間: 投稿された俳句の中で、自分が素晴らしいと思ったものに投票することができます。
投票期間が終了したお題については、結果を見ることができます。得票数に応じて順位が出ます。

URL: https://touku-room.com/

# テスト用アカウント
ID: touku.room.test@gmail.com
PASS: test1234

# 利用方法
①ユーザー登録をする（ヘッダーの新規登録ボタンから登録ページへ行き、必要な項目を入力。）
②アカウントの有効化（登録メールアドレスに送信される認証メール内のリンクをクリック。）
③ログインする（ヘッダーのログインボタンからログインページへ行き、必要な項目を入力。）
④お題を設定する（ヘッダーのお題を設定するボタンからお題設定ページへ行き、お題画像のアップロードとその季節を選択。）
⑤投句する（投句期間であれば、トップページに投句期間中のお題が表示されている。投句するボタンから投句ページへ行き、俳句を入力。）
⑥投票する（投票期間であれば、トップページに投票期間中のお題が表示されている。投票するボタンから投票ページへ行き、素晴らしいと思った俳句の投票ボタンを押すことで投票ができる。）
### その他
・結果を見る（投票期間が終了したお題は、トップページにある過去のお題ボタンから一覧できる。結果を見るボタンからその回の俳句の一覧が得票数順に順位づけられて表示される。）
・ユーザー情報を見る（マイページや各箇所のユーザー名のリンクからユーザーページへ移動することができる。そのユーザーの成績や過去の俳句を見ることができる。）
・俳句の詳細を見る（過去の結果ページやユーザーページに表示されている俳句はリンク化されており、その俳句の詳細ページへ移動することができる。詳細ページでは、その俳句を投稿したお題や、得票数・投票者名などを見ることができる。）

# 目指した課題解決
コロナ禍により、俳句のプレイヤーは急増している。俳句の世界には、何人かで俳句をお互いに見せ合い、フィードバックする「句会」と呼ばれる集まりがあるが、コロナ禍でこのような集会は開催しづらい状況である。加えて、俳句初心者にこのような句会に参加することは非常に勇気のいることであろう。
このように、俳句をこれから始めようという人にとって、挑戦するハードルは高く、気軽に自分の俳句が投稿でき、そのフィードバックをもらう場というのは少ない。
<b>そこで、『投句るうむ』では俳句にこれから挑戦する人にとって気軽に自分の作品を投稿することができ、そのフィードバックが数字という結果としてもらえるようなサービスを提供している。</b>

# 洗い出した要件
スプレッドシートURL: https://docs.google.com/spreadsheets/d/1KQRa4HPwoEzPg6gO84gpaHpEYKrYwpB3m2gBWF8NJL4/edit?usp=sharing

# 実装予定の機能
今後は、以下の機能の実装を目指す。
・管理者機能（管理者にとって有用な情報をまとめた専用ページ）
・コメント機能（投票中の俳句にコメントができる）

# テーブル設計

ER図は touku-room/touku-room.dio に記載。

## usersテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| name               | string     | null: false                    |
| profile            | text       |                                |


### Association
- has_many :haikus
- has_many :themes
- has_many :votes
- has_many :comments(予定)

## themesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| season_id          | integer    | null: false                    |
| status             | integer    | null: false                    |
| user               | reference  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :field

## fieldsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| status             | integer    | null: false                    |
| theme              | references | null: false, foreign_key: true |

### Association
- has_many :haikus
- belongs_to :theme

## haikusテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| content            | string     | null: false                    |
| user               | references | null: false, foreign_key: true |
| field              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :field
- has_many :votes
- has_many :comments(予定)

## votesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| haiku              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :haiku

## commentsテーブル（実装予定予定）
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| content            | text       | null: false                    |
| user               | references | null: false, foreign_key: true |
| haiku              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :haiku