require 'csv'
require 'nokogiri'
require 'date'
require 'open-uri'


def find_or_create_by_name(team)
  if Team.exists?(name: team)
    Team.where(name: team).first.id
  else
    team = Team.new(name: team)
    team.save!
    team.id
  end
end

def get_team(name)
  Team.where(name: name).first.id
end

def import(url)
  page = Nokogiri::HTML(open(url))
  table = page.css('#div_games_left').max_by { |table| table.xpath('.//tr').length }
  rows = table.search('tr')[1..-1]
  cells = rows.search('td//text()').collect {|text| CGI.unescapeHTML(text.to_s) }

  games = cells.each_slice(7).to_a
  games.each do |game|

    if game[0] != 'Week'

      date_from_row = game[2].split(' ')
      month = Date::MONTHNAMES.index(date_from_row[0])
      day = date_from_row[1].to_i
      date = Date.new(2015, month, day)

      away = game[3]
      home = game[5]
      time = game[6] + " EST"

      away_team = find_or_create_by_name(away)
      home_team = find_or_create_by_name(home)

      if Game.exists?(date: date, home_team_id: home_team, away_team_id: away_team)
        puts "Game already in db!"
      else
        matchup = Game.new(date: date, time: time, home_team_id: home_team, away_team_id: away_team)
        matchup.save
      end
    end
  end
end
