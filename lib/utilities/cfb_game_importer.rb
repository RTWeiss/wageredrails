require 'csv'
require 'nokogiri'
require 'date'
require 'open-uri'

# require in rails console, call on schedule url's. Manually input League

def find_or_create_by_name(team)
  if Team.exists?(name: team)
    Team.where(name: team).first.id
  else
    team = Team.new(name: team)
    team.save!
    team.id
  end
end

# returns opponent for games 1 and 2, takes game array as parameter 
def game_opponent(game)
  if game[1].length < 3
    find_or_create_by_name(game[2])
  else
    find_or_create_by_name(game[1])
  end
end

def opponent_id(game)
  if game[1] == "@ "
    Team.where(name: game[2]).first.id
  else
    Team.where(name: game[1]).first.id
  end
end


def determine_home_team(game, parsed_team_id)
  if game[1] == "@ "
    opponent_id(game)
  else
    parsed_team_id
  end
end

def import_finished_game(game, parsed_team_id)
  date_arr = game[0].split('/')
  date = Date.new(2015, date_arr[0].to_i, date_arr[1].to_i)

  if game[1] =~ /@/
    home = find_or_create_by_name(game[2])
    Game.where(date: date, home_team_id: home, away_team_id: parsed_team_id).first_or_create
  else
    away = find_or_create_by_name(game[1])
    Game.where(date: date, home_team_id: parsed_team_id, away_team_id: away).first_or_create
  end
end

def import_upcoming_game(game, parsed_team_id)
  date_arr = game[0].split('/')
  date = Date.new(2015, date_arr[0].to_i, date_arr[1].to_i)

  if game.length == 2
    away = find_or_create_by_name(game[1])
    Game.where(date: date, home_team_id: parsed_team_id, away_team_id: away).first_or_create
  elsif game[1] =~ /@/
    home = find_or_create_by_name(game[2])
    Game.where(date: date, home_team_id: home, away_team_id: parsed_team_id).first_or_create
  elsif game[1] =~ /\d/
    away = find_or_create_by_name(game[2])
    Game.where(date: date, home_team_id: parsed_team_id, away_team_id: away).first_or_create
  end
end

def import(url)
  page = Nokogiri::HTML(open(url))
  table = page.at_css('.team-schedule')
  rows = table.search('tr')
  cells = rows.search('td//text()').collect {|text| CGI.unescapeHTML(text.to_s) }

  team_arr = page.at_css('h1').text.scan(/[a-zA-Z]+/)
  parsed_team_name = team_arr[0] + " " + team_arr[1]
  parsed_team_id = find_or_create_by_name(parsed_team_name)
  
  3.times do |x|
    if cells[1] =~ /@/
      game_arr = cells.take(6)
    else
      game_arr = cells.take(5)
    end

    import_finished_game(game_arr, parsed_team_id)
    cells = cells.drop(game_arr.length)
  end

  until cells.empty? do

    if cells[1] =~ /@/
      game_arr = cells.take(3)
    elsif cells[1] =~ /\d/
      game_arr = cells.take(3)
    elsif cells[1] =~ /[a-zA-Z]/
      game_arr = cells.take(2)
    end

    import_upcoming_game(game_arr, parsed_team_id)
    cells = cells.drop(game_arr.length)
  end
end
