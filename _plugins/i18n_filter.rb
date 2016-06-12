require 'i18n'

LOCALE = :en # set your locale

# Create folder "_locales" and put some locale file from https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale
module Jekyll
  module I18nFilter
    # Example:
    #   {{ post.date | localize: "%d.%m.%Y" }}
    #   {{ post.date | localize: ":short" }}
    def localize(input, format=nil)
      load_translations
      format = (format =~ /^:(\w+)/) ? $1.to_sym : format
      I18n.l input, :format => format
    end

    def translate(input, highlight=true, linebreak=true)
      locale = @context.registers[:page]['locale']

      load_translations

      translation = I18n.t input, locale: locale

      if highlight
        translation.gsub!(/\$([^$]+)\$/, '<span class="highlight">\1</span>')
      else
        translation.gsub!(/\$([^$]+)\$/, '\1')
      end

      translation.gsub!(/\n/, '<br />') if linebreak
      translation
    end

    def field(input, field)
      locale = @context.registers[:page]['locale']
      input["#{field}_#{locale}"]
    end

    def list(input)
      input.split(/\n/)
    end

    def section(name)
      site = @context.registers[:site]
      locale = @context.registers[:page]['locale']

      site.pages.select do |page|
        page.data['section'] == name and page.data['locale'] == locale
      end.first
    end

    def load_translations
      if I18n.backend.send(:translations).empty?
        I18n.backend.load_translations Dir[File.join(File.dirname(__FILE__),'../_locales/*.yml')]
        I18n.locale = LOCALE
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::I18nFilter)
