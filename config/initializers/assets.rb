# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( ualib-home.css )
Rails.application.config.assets.precompile += %w( ualib-discovery.css )
Rails.application.config.assets.precompile += %w( sticky-footer.css )
Rails.application.config.assets.precompile += %w( waypoints.min.js )
Rails.application.config.assets.precompile += %w( smooth-scroll.js )
Rails.application.config.assets.precompile += %w( FeedEk.js )
Rails.application.config.assets.precompile += %w( moment.js )
Rails.application.config.assets.precompile += %w( jquery.canvasjs.min.js )
Rails.application.config.assets.precompile += %w( ualib-home.js )
Rails.application.config.assets.precompile += %w( ualib-discovery.js )

