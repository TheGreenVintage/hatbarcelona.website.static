require 'byebug'

module Jekyll
  class PrivateTourPage < Page
    def initialize(site, base, dir, private_tour, locale)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'private_tour_index.html')
      self.data['tour'] = private_tour
      self.data['locale'] = locale
      self.data['title'] = private_tour["title_#{locale}"]
    end
  end

  class PrivateTourPageGenerator < Generator
    safe true

    def tours_folder(site, locale)
      site.pages.select do |p|
        p.data['section'] == 'private.types' && p.data['locale'] == locale
      end.first
    end

    def generate(site)
      if site.layouts.key? 'private_tour_index'
        private_tours = site.data['private']
        site.config['locales'].each do |locale_array|
          locale = locale_array.first
          private_tours_folder = tours_folder(site, locale)
          private_tours.each do |private_tour|
            name = Utils.slugify(private_tour["title_#{locale}"])
            site.pages << PrivateTourPage.new(site, site.source, File.join(private_tours_folder.permalink[1..-1], name), private_tour, locale)
          end
        end
      end
    end
  end

end
