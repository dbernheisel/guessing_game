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

### COMPUTER GUESSING MODE
# Setup
guesses = []
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
    guessnum = guesses.length+1
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
    #puts guesses
  end
else
  puts "Not implemented yet"
end
