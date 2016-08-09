class Game
  attr_accessor :result

  def initialize (attempt, grid, start_time, end_time)
    @result = { time: end_time - start_time }
    @result[:solution] = solution(grid)
    @result[:test] = in_lexic?(@result[:solution], attempt)
    @result[:score], @result[:message] = score_and_message(
      attempt, @result[:test], grid, @result[:time])
  end

  def self.grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a[rand(26)] }
  end

  def score(attempt, time_taken)
    (time_taken > 60.0) ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end

  def score_and_message(attempt, test, grid, time)
    if test
      if included?(attempt.upcase, grid)
        score = score(attempt, time)
        [score, "well done"]
      else
        [0, "not in the grid"]
      end
    else
      [0, "not an english word"]
    end
  end

  def in_lexic?(words, word)
    words.find_index(word)
  end

  def solution(grid)
    #/usr/share/dict/words
    file = File.open("/home/jonathan/code/Joz84/rails-longest-word-game/db/lexic.txt", "r")
    data = file.read.split("\n")
    file.close
    results = []
    data.each { |word| results << word.upcase if included?(word.upcase, grid) && word.size > 1 }
    results = results.sort_by { |word| word.length}.reverse
  end

  def included?(guess, grid)
    the_grid = grid.clone
    guess.chars.each do |letter|
      the_grid.delete_at(the_grid.index(letter)) if the_grid.include?(letter)
    end
    grid.size == guess.size + the_grid.size
  end
end
