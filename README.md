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

| Culumn     | Type   | Option      |
|------------|--------|-------------|
| nickname   | string | null: false |
| email      | string | null: false |
| password   | string | null: false |
| last_name  | string | null: false |
| first_name | string | null: false |
| birthday   | date   | null: false |

### association

- has_many : items
- has_many : orders

## itemsテーブル

| Culumn          | Type       | Option                         |
|-----------------|------------|--------------------------------|
| name            | string     | null: false                    |
| price           | integer    | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| delivery_charge | string     | null: false                    |
| delivery_source | string     | null: false                    |
| delivery_date   | date       | null: false                    |
| explanation     | text       | null: false                    |
| user            | references | null: false, foreign_key: true |

### association

- belongs_to : user
- has_one : order

## orderテーブル

| Culumn | Type       | Option                         |
|--------|------------|--------------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### association

- belongs_to : user
- belongs_to : item
- has_one : address

| Culumn        | Type       | Option                         |
|---------------|------------|--------------------------------|
| order         | references | null: false, foreign_key: true |
| postal_code   | integer    | null: false                    |
| prefecture    | string     | null: false                    |
| municipality  | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     | null: false                    |
| phone_number  | integer    | null: false                    |

### association

- belongs_to order