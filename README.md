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
| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false               |
| last_name             | string  | null: false               |
| first_name            | string  | null: false               |
| last_name_kana        | string  | null: false               |
| first_name_kana       | string  | null: false               |
| birthday              | date    | null: false               |

### Association
* has_many :items
* has_many :purchases

## items table
| Column                       | Type       | Options           |
| ---------------------------- | ---------- | ------------------|
| item_name                    | string     | null: false       |
| item_description             | string     | null: false       |
| category                     | string     | null: false       |
| item_condition               | string     | null: false       |
| delivery_fee                 | integer    | null: false       |
| delivery_source              | string     | null: false       |
| delivery_date                | string     | null: false       |
| selling_price                | integer    | null: false       |
| user_id                      | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchases table
| Column           | Type       | Options           |
| ---------------- | ---------- | ------------------|
| user_id          | references | foreign_key: true |
| item_id          | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses table
| Column                     | Type        | Options           |
| -------------------------- | ----------- | ------------------|
| postal_code                | string      | null: false       |
| prefectures                | string      | null: false       |
| city                       | string      | null: false       |
| address                    | string      | null: false       |
| building_name              | string      |                   |
| phone_number               | string      | null: false       |
| purchase_id                | references  | foreign_key: true |

### Association
- belongs_to :purchase
