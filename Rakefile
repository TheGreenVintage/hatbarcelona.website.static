require 'open-uri'
require 'csv'
require 'yaml'

I18N_FILE = "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=0&single=true&output=csv"
DATA_FILES = {
  packages: "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=551081751&single=true&output=csv",
  menus:    "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=1411098766&single=true&output=csv",
  private:  "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=1560876386&single=true&output=csv",
  regulars: "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=752097460&single=true&output=csv",
}

task :i18n do
  puts "Downloading i18n files..."

  open(I18N_FILE) do |file|
    csv2yaml(file)
  end

  puts 'Done!'
end

task :data do
  puts "Downloading data files..."
  DATA_FILES.each do |key, value|
    download(value, "_data/#{key}.csv")
  end
end

def download(url, path)
  open(url) {|f|
    File.open(path,"wb") do |file|
      file.puts f.read.gsub(/\r\n/, "\n")
    end
  }
end

def csv2yaml(file)
  data = CSV.read(file, :headers => true, :encoding => 'UTF-8')

  headers = data.headers
  master = headers.slice!(0)
  translations = data.map(&:to_hash)

  languages = headers.map do |header|
    language = {}

    language[header] = translations.reduce({}) do |memo, translation|
      key = translation[master]
      value = translation[header]

      next unless key

      puts("Processing #{key}...")

      key_path = key.split('.') rescue puts("Error in #{key}")

      hash = memo

      loop do

        if key_path.length == 1
          value.strip! rescue puts("Error in #{key_path}")
          value = YAML.load(value) if key_path.first.end_with? '_list'

          hash[key_path.first] = value
        else
          step_hash = hash[key_path.first] || {}
          hash[key_path.first] = step_hash
          hash = step_hash
        end

        key_path.slice!(0)

        break if key_path.empty?
      end

      memo
    end

    language
  end

  languages.each do |language|
    File.open("_locales/#{language.keys.first}.yml", 'w') do |f|
      f.write "# Do not edit this generated file\n"
      f.write language.to_yaml
    end
  end
end
