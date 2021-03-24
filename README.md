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
| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| name       | string | null: false |

### Association
* has_many :items

## items table
| Column           | Type       | Options           |
| ---------------- | ---------- | ------------------|
| category         | string     | null: false       |
| item_condition   | string     | null: false       |
| user_id          | references | foreign_key: true |

### Association
- belongs_to :user

## purchases table
| Column                     | Type        | Options           |
| -------------------------- | ----------- | ------------------|
| card_number                | integer     | null: false       |
| selling_price              | integer     | null: false       |
| shipping fee               | string      | null: false       |
| shipment_from_address      | string      | null: false       |
| estimated_date_of_shipment | string      | null: false       |

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
