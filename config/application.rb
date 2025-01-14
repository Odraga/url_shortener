require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UrlShortener
  class Application < Rails::Application
    config.load_defaults 8.0
    config.api_only = true

    # Configuración para habilitar CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:5173' # Dominio del frontend
        resource '*',
                 headers: :any,
                 methods: [:get, :post],
                 credentials: true
      end
    end
  end
end
