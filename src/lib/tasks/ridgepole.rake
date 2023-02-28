# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

namespace :ridgepole do
    desc "Apply ridgepole schemafile"
    task apply: :environment do
      ridgepole('--apply')
    end
  
    desc "Export ridgepole schemafile"
    task export: :environment do
      ridgepole('--export')
    end
  
    private
    def config_file
      if Rails.env.development?
        'config/database.yml'
      elsif Rails.env.staging?
        'config/database.staging.yml'
      elsif Rails.env.production?
        'config/database.production.yml'
      else
        raise 'no configuration specified'
      end
    end
  
    def ridgepole(*options)
      command = ['bundle exec ridgepole --file db/schemas/Schemafile', "-c #{config_file}", "-E #{Rails.env}"]
      system (command + options).join(' ')
    end
  end
