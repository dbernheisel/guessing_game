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
puts "           NUMBER GUESSING GAME\n\n"


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
sensible_guesses = []
themagicnumber = (1..100).to_a.sample
#puts themagicnumber
if !compguess
  while true
    if guesses.length == 5
      leave("You lose!")
    end

    print "Your guess: "
    guess = gets.chomp!

    if guess_right?(guess.to_i, themagicnumber)
      puts "You win!"
      break
    end

    if guess == ""
      puts "Too scared to play?"
      next
    end

    if !is_integer?(guess)
      puts "Dawg, we're guessing whole numbers, not baby names."
      next
    end

    if guesses.include? guess
      puts "Dawg, take some ginko. Try again."
      puts "Here are your guesses so far: #{guesses}"
      next
    end

    if guess.to_i > themagicnumber
      puts("You guessed too high.")
    else
      puts("You guessed too low.")
    end

    if sensible_guesses.length > 0
      sensible_guesses.each do |n|
        if (guess > n && themagicnumber > n) || (guess < n && themagicnumber < n)
          puts "This is a sensible guess"
          sensible_guesses << guess
        else
          puts "This is not a sensible guess"
        end
      end
    end
    guesses << guess
    #puts guesses
  end
else
  puts "Not implemented yet"
end
