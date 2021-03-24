# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計

## users table
| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| email                 | string  | null: false |
| password              | string  | null: false |
| last_name             | string  | null: false |
| first_name            | string  | null: false |
| last_name_ruby        | string  | null: false |
| first_name_ruby       | string  | null: false |
| birthday              | integer | null: false |

### Association
* has_many :items
- has_one :purchase

## items table
| Column           | Type       | Options           |
| ---------------- | ---------- | ------------------|
| category         | string     | null: false       |
| item_condition   | string     | null: false       |
| user_id          | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchases table
| Column           | Type       | Options           |
| ---------------- | ---------- | ------------------|
| user_id          | references | foreign_key: true |
| item_id          | references | foreign_key: true |

### Association
- has_one :shipping_address

## shipping_addresses table
| Column                     | Type        | Options           |
| -------------------------- | ----------- | ------------------|
| postal_code                | integer     | null: false       |
| prefectures                | string      | null: false       |
| city                       | string      | null: false       |
| address                    | integer     | null: false       |
| building_name              | string      |                   |
| phone_number               | integer     | null: false       |


### Association
- belongs_to :purchase
