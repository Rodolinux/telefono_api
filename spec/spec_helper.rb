require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
Capybara.app = Rails.application
Capybara.default_driver = :rack_test  # Para pruebas rápidas sin navegador real
