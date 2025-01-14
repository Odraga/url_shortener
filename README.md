# README

This README provides the necessary steps and information to get the application up and running, as well as details about its configuration and usage.

## Ruby Version

Specify the Ruby version required for this project:
- Ruby 3.2.0 (or the version specified in `.ruby-version` if available)

## Configuration

1. Clone the repository:
   ```bash
   git clone https://github.com/odraga/url_shortener.git
   cd url_shortener
   ```
2. Install Ruby gems:
   ```bash
   bundle install
   ```

## Database Creation

Set up the database by running:
```bash
rails db:create
```

## Database Initialization

Run the database migrations and seed data:
```bash
rails db:migrate
rails db:seed
```

## How to Run the Test Suite

To run the test suite, execute:
```bash
rails test
```
If you are using RSpec:
```bash
bundle exec rspec
```

## Services (Job Queues, Cache Servers, Search Engines, etc.)

- **Job Queues:** Ensure you have the necessary background job processor (e.g., Sidekiq or Delayed Job) running:
  ```bash
  bundle exec sidekiq
  ```
- **Cache Servers:** Configure a caching server (e.g., Redis) if required. Start Redis with:
  ```bash
  redis-server
  ```
## Deployment Instructions

To deploy the application:
1. Ensure the production environment is properly configured.
2. Precompile assets:
   ```bash
   rails assets:precompile
   ```
3. Migrate the production database:
   ```bash
   rails db:migrate RAILS_ENV=production
   ```
4. Restart the server.

## Additional Information

- **Background Jobs:**
  Background jobs are handled using ActiveJob. Ensure the configured adapter (e.g., Sidekiq, Delayed Job) is running.

- **ScrapePageTitleJob:**
  This job scrapes the title of a given webpage using Selenium. Ensure that Selenium WebDriver and a compatible browser (e.g., Chrome) are installed.
  ```bash
  brew install --cask google-chrome
  brew install chromedriver
  ```

- **Environment Variables:**
  Configure environment variables for sensitive data (e.g., API keys) using a library like [dotenv](https://github.com/bkeepers/dotenv). Add the variables to `.env` and ensure it is excluded from version control.

---

Feel free to modify this README to include additional sections or details as needed.
