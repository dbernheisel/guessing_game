#!/usr/bin/env ruby

def leave(message)
  puts "#{message}"
  exit
end

def guess_right?(guess, answer)
  return true if guess == answer
  return false
end

def is_integer?(n)
  return true if n.to_i.to_s == n
  return false
end

class Fixnum
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
        when 1; "#{self}st"
        when 2; "#{self}nd"
        when 3; "#{self}rd"
        else    "#{self}th"
      end
    end
  end
end

crystal = %q{
                 _.---._
            *  .'       '.  *
           *  /  # #      \  *
             | #           |
          *  |             |  *
              \       //  /
           *   '.       .'  *
             *   `'---'`  *
                  )___(
                 )_____(
                (_______)
}


# Introduction
puts crystal
puts "           NUMBER GUESSING GAME"
puts "            Let's play a game."
puts "  Let's guess a number between 1 and 100"
puts "         There shall be 5 guesses.\n\n"


# Determine which mode to play
print "Who should guess the number? The computer or human?: "
compguessresponse = gets.chomp!
compguess = false
case compguessresponse
when "computer"
  compguess = true
when "human"
  compguess = false
else
  leave("Not a valid response")
end


###
### HUMAN GUESSING MODE
###
guesses = []
guessnum = guesses.length+1
closest_high_guess = 100
closest_low_guess = 1
themagicnumber = (1..100).to_a.sample
#puts themagicnumber
if !compguess
  puts ""
  while true
    if guesses.length == 5
      leave("You lose! The number was #{themagicnumber}")
    end

    print "Your #{guessnum.ordinalize} guess: "
    guess = gets.chomp!


    if guess_right?(guess.to_i, themagicnumber)
      puts "You win!"
      break
    end

    if guess == ""
      puts "Too scared to play?"
      next
    end

    if guess.to_i < 1
      puts "We're guessing non-zero and positive numbers"
      next
    end

    if !is_integer?(guess)
      puts "Dawg, we're guessing whole numbers, not baby names."
      next
    end

    if guesses.include? guess.to_i
      puts "Dawg, take some ginko. Try again."
      puts "Here are your guesses so far: #{guesses}"
      next
    end

    guess = guess.to_i
    if guess > themagicnumber
      puts("You guessed too high.")
      if guess > closest_high_guess
        puts "Why did you guess higher?"
      else
        closest_high_guess = guess
      end
    else
      puts("You guessed too low.")
      if guess < closest_low_guess
        puts "Why did you guess lower?"
      else
        closest_low_guess = guess
      end
    end

    guesses << guess
    guessnum = guesses.length + 1
    #puts guesses
  end
else
###
### COMPUTER GUESSING MODE
###
  puts "When I guess, I need you to tell me if it's"
  puts "too \"high\", too \"low\", or \"correct\"\n\n"
  puts "Pick a number. Press enter when you're ready."
  gets.chomp!

  # Setup
  correct = false
  guesspool = (1..100).to_a

  while !correct
    if guesses.length == 5
      if guesspool.length == 1
        leave("I lost, but I know the answer: #{guesspool[0]}")
      end
      leave("I lose! Nooooooooooooooooooo")
    end

    if guesspool.length == 0
      leave("You LIAR!!!")
    end

    guess = guesspool.sample

    if guesspool.length < 2
      puts "I guessed it! I win!"
      leave("The the correct number was #{guesspool[0]}")
    end

    puts "My #{guessnum.ordinalize} guess: #{guess}"
    print "Am I correct, high, or low?: "
    response = gets.chomp!
    if (response == "low" && guess == 100) || (response == "high" && guess == 1)
      puts "Stop playin' with me"
      next
    end

    case response
    when "high"
      guesspool.delete_if { |n| n > guess }
      guesses << guess
    when "low"
      guesspool.delete_if { |n| n < guess }
      guesses << guess
    when "correct"
      puts "Suck it."
      correct = true
    else
      puts "What? You sassin' me?"
    end

    guesspool.delete(guess)
    guessnum = guesses.length + 1

  end

end
