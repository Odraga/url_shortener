class ScrapePageTitleJob < ApplicationJob
  queue_as :default

  def perform(url)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')      # Evita problemas con gráficos en headless mode
    options.add_argument('--no-sandbox')       # Necesario si estás ejecutando en Docker o en un entorno con restricciones de seguridad

    driver = Selenium::WebDriver.for :chrome, options: options

    driver.get(url)

    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { driver.title != "" }

    title = driver.title
    driver.quit

    UrlShort.find_by(original_url: url).update(title: title)
  end
end
