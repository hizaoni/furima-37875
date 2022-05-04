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

# データベース設計

## usersテーブル

| Column             | Type   | Option      |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### association

- has_many : items
- has_many : orders

## itemsテーブル

| Column        | Type       | Option                         |
|---------------|------------|--------------------------------|
| name          | string     | null: false                    |
| price         | integer    | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| charge_id     | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| date_id       | integer    | null: false                    |
| explanation   | text       | null: false                    |
| user          | references | null: false, foreign_key: true |

### association

- belongs_to : user
- has_one : order

## ordersテーブル

| Column | Type       | Option                         |
|--------|------------|--------------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### association

- belongs_to : user
- belongs_to : item
- has_one : address

| Column        | Type       | Option                         |
|---------------|------------|--------------------------------|
| order         | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture_id | string     | null: false                    |
| municipality  | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |

### association

- belongs_to order