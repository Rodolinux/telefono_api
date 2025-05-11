# spec/rails_helper.rb

#ENV['RAILS_ENV'] ||= 'test'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rspec' # Asegúrate de tener esto si usas Capybara
# Configurar Capybara
Capybara.default_driver = :rack_test
Capybara.app = Rails.application

RSpec.configure do |config|
  config.before(:suite) do
    puts "--- Middlewares en el entorno de prueba ---"
    Rails.application.config.middleware.each do |middleware|
      puts middleware.klass.name
    end
    puts "--- Fin de los Middlewares ---"
    puts "--- Configuración de Hosts en el entorno de prueba ---"
    puts Rails.application.config.hosts.inspect
    puts "--- Fin de la Configuración de Hosts ---"
    end
  config.use_transactional_fixtures = true
  config.include ActiveSupport::Testing::FileFixtures, :example
  config.file_fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end