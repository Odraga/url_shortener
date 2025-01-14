class ScrapePageTitleJob < ApplicationJob
  queue_as :default

  def perform(url)
    begin
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
  
    driver = Selenium::WebDriver.for :chrome, options: options
  
    driver.get(url)
  
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { driver.title != "" }
  
    title = driver.title
    driver.quit
  
    # Si el título está vacío o es null, asignar "Anonymous"
    UrlShort.find_by(original_url: url).update(title: title)
    rescue => e
      UrlShort.find_by(original_url: url).update(title: "Anonymous")

    end
  end
  
end
