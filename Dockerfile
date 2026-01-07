# Build stage
FROM ruby:3.2-alpine AS builder

RUN apk add --no-cache build-base gcc cmake git

WORKDIR /app

COPY Gemfile Gemfile.lock* ./
RUN bundle install --jobs 4 --retry 3

COPY . .
RUN bundle exec jekyll build

# Production stage - serve with nginx
FROM nginx:alpine

COPY --from=builder /app/_site /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
