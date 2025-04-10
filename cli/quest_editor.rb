# quest_editor.rb
#
# This file lets you create new quests.
# Quests are stored in plain JSON and all loaded
# at the same time as the players save.
# Quests have a unique JSON format, and are a
# bit hard to explain, but the schema example
# is left in this comment for you to read.
#
# {
#   "quest_id": {
#     "quest_name": "",
#     "quest_id": "",
#     "quest_provider": int,
#     "quest_steps": [
#       "..."
#     ],
#     "has_cutscene_pre": bool,
#     "has_cutscene_post": bool,
#     "rewards": [
#       ...
#     ]
#   }
# }

require 'json'
require 'fileutils'

def prompt(field)
  print "#{field} (or 'q' to quit): "
  input = gets.chomp
  exit if input.downcase == 'q'
  input
end

def collect_quest_steps
  puts "Enter quest steps one-by-one. '!' to finish:"
  steps = []

  loop do
    print "  Step: "
    input = gets.chomp
    break if input == '!'
    exit if input == 'q'
    steps << input unless input.empty?
  end

  steps
end

def collect_quest_rewards
  puts "Enter reward item IDs one-by-one. '!' to finish:"
  rewards = []

  loop do
    print "  Reward: "
    input = gets.chomp
    break if input == '!'
    exit if input == 'q'
    rewards << input unless input.empty?
  end

  rewards
end

def save_quest_to_file(quest_data)
  FileUtils.mkdir_p("quests")
  file_path = "quests/#{quest_data.keys.first}.json"
  File.open(file_path, 'w') do |file|
    file.write(JSON.pretty_generate(quest_data))
  end
  puts "Saved to #{file_path}"
end

def create_quest
  quest_id = prompt("Quest ID:")
  quest_name = prompt("Quest Name:")
  qid_int = quest_id.to_i
  quest_provider = prompt("Quest Provider:")
  quest_steps = collect_quest_steps
  quest_rewards = collect_quest_rewards

  {
    quest_id => {
      "quest_name" => quest_name,
      "quest_id" => qid_int,
      "quest_provider" => quest_provider,
      "quest_steps" => quest_steps,
      "quest_rewards" => quest_rewards
    }
  }
end

def main
  puts '%%% QuestEditor for NeonDreams %%%'
  quest = create_quest
  save_quest_to_file(quest)
end

main