Rails.application.configure do
  # config.force_ssl = true
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true # false

  # Do not eager load code on boot.
  config.eager_load = true # false

  # Show full error reports.
  config.consider_all_requests_local = false # true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true 

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  config.active_job.queue_adapter = :async

  config.action_mailer.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: 2525,
    domain: Rails.application.secrets.domain_name,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: Rails.application.secrets.email_provider_username,
    password: Rails.application.secrets.email_provider_password
  }

#  config.action_mailer.smtp_settings = {
#    address:              'smtp.gmail.com',
#    port:                 587,
#    port:                 2525,
#    domain:               'gmail.com',
#    user_name:            'letsapp.com.hk@gmail.com',
#    password:             'G58305919m',
#    authentication:       :plain,
#    enable_starttls_auto: true
#  }
  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'https://hwfc.letsapp.cloud' }
  #config.action_mailer.default_url_options = { :host => 'http://localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  # Send email in development mode?
  config.action_mailer.perform_deliveries = true
  #config.action_mailer.perform_deliveries = false

  config.action_mailer.perform_caching = true # false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false # true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :error # :debug
  
  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_cable.url = "ws://localhost:3000/cable"
  config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]
end