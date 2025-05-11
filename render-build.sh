#!/usr/bin/env bash

set -e  # Salir si hay algún error

# Instalar dependencias en modo producción
RACK_ENV=production bundle install --without development test --path vendor/bundle

# Opcional: Precompilar assets si usas Turbo/Propshaft
# RAILS_ENV=production bundle exec rake assets:precompile