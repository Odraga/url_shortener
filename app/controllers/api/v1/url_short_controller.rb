require 'selenium-webdriver'
require 'open-uri'

module Api
  module V1
    class UrlShortController < ApplicationController
      # GET /url_shorts
      def index
        url_shorts = UrlShort.all
        render json: url_shorts
      end

      # GET /url_shorts/:id
      def show
        url_short = UrlShort.find_by(shortener_url: params[:id])

        if url_short
          render json: url_short
        else
          render json: { error: "URL not found" }, status: :not_found
        end
      end

      # POST /url_shorts
      def create
        # Make scraping
        begin
          url_short = UrlShort.new(url_short_params)

          


          url_short.title = get_page_title(url_short.original_url)
          url_short.shortener_url = generate_shortened_url()  # Generate URl Short
          url_short.click_count = 0  

          if url_short.save
            render json: url_short, status: :created
          else
            render json: url_short.errors, status: :unprocessable_entity
          end 
    
        rescue => e
          render json: { error: "Error scraping URL: #{e.message}" }, status: :unprocessable_entity
          return
        end
      end

      # PATCH/PUT /url_shorts/:id
      def update
        url_short = UrlShort.find(params[:id])
        if url_short.update(url_short_params)
          render json: url_short
        else
          render json: url_short.errors, status: :unprocessable_entity
        end
      end

      # DELETE /url_shorts/:id
      def destroy
        url_short = UrlShort.find(params[:id])
        url_short.destroy
        head :no_content
      end

      private

      # Params Availables
      def url_short_params
        params.require(:url_short).permit(:title, :original_url, :shortener_url, :click_count)
      end

      private

       # Method to generate a short URL based on the page title
      def generate_shortened_url()
        new_url = SecureRandom.alphanumeric(8) 
        "#{new_url}"
      end
      
      def get_page_title(url)
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options

        driver.get(url)

        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        wait.until { driver.title != "" }

        title = driver.title
        driver.quit

        title
      end
    end


  end
end
