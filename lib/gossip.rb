# frozen_string_literal: true

require 'csv'
require 'pry'
class Gossip
  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
    CSV.open('./db/gossip_commentaires.csv', 'ab') do |csv|
      csv << ['no comment']
    end
  end

  def self.all
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end

    all_gossips
  end

  def self.find(id)
    ligne = []
    CSV.read('./db/gossip.csv').each_with_index do |csv, i|
      ligne = csv if i == (id - 1)
    end

    ligne
  end

  def self.update(id, info)
    arr = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      arr << csv_line
    end
    CSV.open('./db/gossip.csv', 'wb') do |csv|
      arr.each_with_index do |line, i|
        csv << if (id - 1) == i
                 info
               else
                 line
               end
      end
    end
  end

  def self.save_comments(id, infos)
    id -= 1
    arr = []
    CSV.read('./db/gossip_commentaires.csv').each do |csv_line|
      arr << csv_line
    end

    if arr[id] == ['no comment']
      arr[id] = [infos]
    else arr[id] << infos
    end
    CSV.open('./db/gossip_commentaires.csv', 'wb') do |csv|
      arr.each do |line|
        csv << line
      end
    end
  end

  def self.find_comments(id)
    arr = []
    index = 1
    CSV.read('./db/gossip_commentaires.csv').each do |csv_line|
      if index == id
        arr << csv_line
        return arr
      end
      index += 1
    end
    arr
  end

  def self.delete_all
    CSV.open('./db/gossip.csv', 'wb') do |_csv|
    end
    CSV.open('./db/gossip_commentaires.csv', 'wb') do |_csv|
    end
  end
end
