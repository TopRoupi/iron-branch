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

### todo list

- [x] Pagination on company index
- [x] Pagination on company investments_on
- [x] companies#new_invested_invesment controller 
- [x] companies#new_investor_invesment controller 
- [x] mark anomalous when creating a circular investment 
- [ ] update anomalous when creating or updating companies investments 
