FROM ruby:3.2.8-slim AS builder

# Instalar dependencias necesarias para construir las gems nativas
RUN apt-get update -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    libyaml-dev

# Limpiar la caché de Bundler y forzar la reinstalación sin development y test


WORKDIR /app

# Copiar Gemfile y Gemfile.lock PRIMERO
COPY Gemfile Gemfile.lock ./

# Eliminar explícitamente jruby-openssl del Gemfile.lock
RUN sed -i '/jruby-openssl/d' Gemfile.lock

# Limpiar la caché de Bundler y forzar la reinstalación sin development y test
RUN bundle config --delete path
RUN rm -rf /usr/local/bundle
RUN bundle install --without development test

# Copiar el resto de la aplicación DESPUÉS de la instalación de gems
COPY . .

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE="354afcf319ab3a0050836380e9a9f9460e53978795de0c3ef83c1d4adc142ef3d5f331d56d254b0288367e30e242f9ea5d9bf54d3144d800cd793997ee118f1d"


# Precompilar los assets (con precauciones para bootsnap)
RUN bundle exec spring stop || true
#RUN rails runner "Rails.application.config.cache_classes = true"
RUN rails runner "Rails.application.load_seed" || true
RUN RAILS_ENV=production SECRET_KEY_BASE="$SECRET_KEY_BASE" bundle exec rails assets:precompile

FROM ruby:3.2.8-slim

# Instalar dependencias necesarias para ejecutar la aplicación
RUN apt-get update -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    libyaml-dev

WORKDIR /app

# Copiar la aplicación construida
COPY --from=builder /app .

# Establecer variables de entorno (ajusta según tus necesidades)
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV PORT 8080
# Si usas una base de datos, configura DATABASE_URL como variable de entorno en Cloud Run

# Exponer el puerto en el que escucha Puma
EXPOSE 8080
# declarar explícitamente el path para que cargue las gemas
ENV PATH="/usr/local/bundle/bin:$PATH"
# Comando para iniciar el servidor Puma
CMD ["bundle", "exec", "puma", "-p", "8080"]