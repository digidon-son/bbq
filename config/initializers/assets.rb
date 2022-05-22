# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('node_modules/bootstrap-icons/font')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

class AssetUrlProcessor
  def self.call(input)
    # don't know why, copy from other processor
    context = input[:environment].context_class.new(input)
    data = input[:data].gsub(/url\(["']?(.+?)["']?\)/i) do |match|
      asset = Regexp.last_match(1)
      if asset && asset !~ /(data:|http)/i
        path = context.asset_path(asset)
        "url(#{path})"
      else
        match
      end
    end

    { data: }
  end
end

Sprockets.register_postprocessor 'text/css', AssetUrlProcessor

Rails.application.config.assets.precompile += %w[application.js]
