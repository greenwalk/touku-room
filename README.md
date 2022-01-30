# テーブル設計

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
- has_many :comments

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
| content_sub        | string     | null: false                    |
| user               | references | null: false, foreign_key: true |
| field              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :field
- has_many :votes
- has_many :comments

## votesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| haiku              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :haiku

## commentsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| content            | text       | null: false                    |
| user               | references | null: false, foreign_key: true |
| haiku              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :haiku