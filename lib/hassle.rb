require 'sass'
require 'sass/plugin'

class Hassle
  def setup
    Sass::Plugin.options[:cache] = false
    Sass::Plugin.options[:never_update] = false
    FileUtils.mkdir_p(css_location)
  end

  def css_location
    File.join(Dir.pwd, "tmp", "hassle")
  end

  def compile
    setup

    if Sass::Plugin.options[:template_location]
      Sass::Plugin.options[:template_location].keys.each do |key|
        Sass::Plugin.options[:template_location][key] = css_location
      end
    else
      Sass::Plugin.options[:template_location] = File.join(Sass::Plugin.options[:css_location], "sass")
    end

    Sass::Plugin.options[:css_location] = css_location
    Sass::Plugin.update_stylesheets
  end
end
