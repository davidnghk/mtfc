require_relative 'boot'

require 'csv'
require 'rails/all'
require 'pdfkit'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FieldConnect
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Hong Kong'
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # Install chinese fonts
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('/app/assets/fonts')
    
    #module BackgroundJobsWithSidekiq
    #  class Application < Rails::Application
    #    config.active_job.queue_adapter = :sidekiq 
        # config.active_job.queue_adapter = Rails.env.production? ? :sidekiq : :async
    #  end
    #end
    # Install delayed Job for email
    #config.active_job.queue_adapter = :delayed_job

    config.middleware.use PDFKit::Middleware, :print_media_type => true
  end
end
