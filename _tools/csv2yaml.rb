#!/bin/ruby

require 'csv'
require 'yaml'

data = CSV.read(ARGV[0], :headers => true)

headers = data.headers
master = headers.slice!(0)
translations = data.map(&:to_hash)

languages = headers.map do |header|
  language = {}

  language[header] = translations.reduce({}) do |memo, translation|
    key = translation[master]
    value = translation[header]

    key_path = key.split('.')

    hash = memo

    loop do

      if key_path.length == 1
        value.strip! rescue puts "#{key_path}" # TODO: Handle errors
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
  File.open("#{language.keys.first}.yml", 'w') do |f|
    f.write "# Do not edit this generated file\n"
    f.write language.to_yaml
  end
end
