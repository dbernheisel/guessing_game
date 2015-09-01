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


crystal = "\e[0;36m                 _.---._\n"
crystal += "            *  .'       '.  *\n"
crystal += "           *  /  # #      \  *\n"
crystal += "             | #           |\n"
crystal += "          *  |             |  *\n"
crystal += "              \       //  /\n"
crystal += "           *   '.       .'  *\n"
crystal += "             *   `'---'`  *\e[0m\n"
crystal += "                  \e[0;31m)___(\n"
crystal += "                 )_____(\n"
crystal += "                (_______)\e[0m\n"


# Introduction
puts crystal
puts "           NUMBER GUESSING GAME"
puts "            Let's play a game."
puts "  Let's guess a number between 1 and 100"
puts "         There shall be 5 guesses.\n\n"


# Determine which mode to play
print "Who should guess the number? The \e[0;36mcomputer\e[0m or \e[0;36mhuman\e[0m?: "
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
      leave("\e[41mYou lose! The number was #{themagicnumber}\e[0m")
    end

    print "Your #{guessnum.ordinalize} guess: "
    guess = gets.chomp!


    if guess_right?(guess.to_i, themagicnumber)
      puts "\e[42mYou win!\e[0m"
      break
    end

    if guess == ""
      puts "\e[91mToo scared to play?\e[0m"
      next
    end

    if guess.to_i < 1
      puts "\e[91mWe're guessing non-zero and positive numbers.\e[0m"
      next
    end

    if !is_integer?(guess)
      puts "\e[91mDawg, we're guessing whole numbers, not baby names.\e[0m"
      next
    end

    if guesses.include? guess.to_i
      puts "\e[91mDawg, take some ginko. Try again.\e[0m"
      puts "Here are your guesses so far: #{guesses}"
      next
    end

    guess = guess.to_i
    if guess > themagicnumber
      puts("\e[91mYou guessed too high.\e[0m")
      if guess > closest_high_guess
        puts "\e[41mWhy did you guess higher?\e[0m"
      else
        closest_high_guess = guess
      end
    else
      puts("\e[91mYou guessed too low.\e[0m")
      if guess < closest_low_guess
        puts "\e[41mWhy did you guess lower?\e[0m"
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
  puts "too \"\e[0;36mhigh\e[0m\", too \"\e[0;36mlow\e[0m\", or \"\e[0;36mcorrect\e[0m\"\n\n"
  puts "Pick a number. Press enter when you're ready."
  gets.chomp!

  # Setup
  correct = false
  guesspool = (1..100).to_a

  while !correct
    if guesses.length == 5
      if guesspool.length == 1
        leave("\e[41mI lost, but I know the answer: #{guesspool[0]}\e[0m")
      end
      leave("\e[41mI lose! Nooooooooooooooooooo\e[0m")
    end

    if guesspool.length == 0
      leave("\e[41mYou LIAR!!!\e[0m")
    end

    guess = guesspool.sample

    if guesspool.length < 2
      puts "\e[42mI guessed it! I win!\e[0m"
      leave("The the correct number was #{guesspool[0]}")
    end

    puts "My #{guessnum.ordinalize} guess: \e[1m#{guess}\e[0m"
    print "Am I correct, high, or low?: "
    response = gets.chomp!
    if (response == "low" && guess == 100) || (response == "high" && guess == 1)
      puts "\e[41mStop playin' with me\e[0m"
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
      puts "\e[41mSuck it.\e[0m"
      correct = true
    else
      puts "\e[41mWhat? You sassin' me?\e[0m"
    end

    guesspool.delete(guess)
    guessnum = guesses.length + 1

  end

end
