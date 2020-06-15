# REQUIREMENTS


* Ruby version

  ```
  2.6.5
  ```

* System dependencies

  ```
  Postgresql 11.5
  ```

* Configuration

* Database setup

  ```sh
  rails db:create db:migrate db:seed
  ```

* How to run the test suite

  ```sh
  rails test
  ```

* Deployment instructions

  ```sh
  heroku git:remote -a iron-branch
  git push origin heroku
  ```