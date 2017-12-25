variable "heroku_email" { }
variable "heroku_api_key" { }

provider "heroku" {
  email   = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "default" {
  name   = "test-app-from-terraform"
  region = "us"

  config_vars {
    LANG="en_US.UTF-8"
    RACK_ENV="production"
    RAILS_ENV="production"
  }

  buildpacks = [
    "heroku/nodejs",
    "heroku/ruby"
  ]
}

resource "heroku_addon" "database" {
  app = "${heroku_app.default.name}"
  plan = "heroku-postgresql:hobby-dev"
}
