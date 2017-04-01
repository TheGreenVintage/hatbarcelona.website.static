require 'byebug'

module Jekyll

  class RegularTourPage < Page
    def initialize(site, base, dir, regular_tour, locale)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'regular_tour_index.html')
      self.data['tour'] = regular_tour
      self.data['locale'] = locale
      self.data['title'] = regular_tour["title_#{locale}"]
    end
  end

  class RegularTourPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'regular_tour_index'
        site.config['locales'].each do |locale_array|
          locale = locale_array.first
          regular_tours = site.data['regulars']
          regular_tours.each do |regular_tour|
            name = Utils.slugify(regular_tour["title_#{locale}"])
            site.pages << RegularTourPage.new(site, site.source, File.join(locale, 'tours', 'regulars', name), regular_tour, locale)
          end
        end
      end
    end
  end

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

    def generate(site)
      if site.layouts.key? 'private_tour_index'
        site.config['locales'].each do |locale_array|
          locale = locale_array.first
          private_tours = site.data['private']
          private_tours.each do |private_tour|
            name = Utils.slugify(private_tour["title_#{locale}"])
            site.pages << PrivateTourPage.new(site, site.source, File.join(locale, 'tours', 'private', name), private_tour, locale)
          end
        end
      end
    end
  end

end
