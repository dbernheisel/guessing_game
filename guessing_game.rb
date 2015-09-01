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
puts "           \e[1mNUMBER GUESSING GAME\e[0m"
puts "            Let's play a game."
puts "  Let's guess a number between 1 and 100"
puts "         There shall be 5 guesses.\n\n"


# Determine which mode to play
print "Who will guess the number? The \e[0;36mcomputer\e[0m or \e[0;36mhuman\e[0m?: "
comp_guess_response = gets.chomp!
comp_guess = false
case comp_guess_response
when "computer"
  comp_guess = true
when "human"
  comp_guess = false
else
  leave("Not a valid response")
end


###
### HUMAN GUESSING MODE
###
guesses = []
guess_num = guesses.length+1
closest_high_guess = 100
closest_low_guess = 1
the_magic_number = (1..100).to_a.sample
correct = false
#puts the_magic_number
if !comp_guess
  puts ""
  while !correct

    # Check if guess limit was reached
    if guesses.length == 5
      leave("\e[41mYou lose! The number was #{the_magic_number}\e[0m")
    end

    # Collect guess from user
    print "Your #{guess_num.ordinalize} guess: \e[1m"
    guess = gets.chomp!
    print "\e[0m"

    # Check if guess is empty
    if guess == ""
      puts "\e[91mToo scared to play?\e[0m"
      next
    end

    # Check if guess is a whole number.
    if !is_integer?(guess)
      puts "\e[91mDawg, we're guessing whole numbers, not baby names.\e[0m"
      next
    end

    # Check if guess is something positive and non-zero.
    if guess.to_i < 1 || guess.to_i > 101
      puts "\e[91mWe're guessing non-zero and positive numbers between 1 and 100\e[0m"
      next
    end

    # Now we know it's a number. Let's convert it.
    guess = guess.to_i

    # Check if guess is correct
    if guess_right?(guess, the_magic_number)
      correct = true
      leave("\e[42mYou win!\e[0m\a")
    end

    # Check if guess was already guessed.
    if guesses.include? guess
      puts "\e[91mDawg, take some ginkgo biloba. Try again.\e[0m"
      puts "Here are your guesses so far: #{guesses}"
      next
    end

    # Guess was wrong, let's tell them if it's too high or low.
    # We'll also track if the guess was sensible based on previous guesses.
    if guess > the_magic_number
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

    # Track guesses.
    guesses << guess
    guess_num = guesses.length + 1
  end
else


  ###
  ### COMPUTER GUESSING MODE
  ###

  # Introduction
  puts "When I guess, I need you to tell me if it's"
  puts "too \"\e[0;36mhigh\e[0m\", too \"\e[0;36mlow\e[0m\", or \"\e[0;36mcorrect\e[0m\"\n\n"
  puts "Pick a number. Press enter when you're ready."
  gets.chomp!

  # Setup variables and loop
  guess_pool = (1..100).to_a
  while !correct

    # Check if guess limit was reached
    if guesses.length == 5
      guess_pool.length == 1 ? leave("\e[41mI lost, but I know the answer: #{guess_pool[0]}\e[0m") : nil
      leave("\e[41mI lose! Nooooooooooooooooooo\e[0m")
    end

    # Check if guess pool is empty, if so imply the user cheated.
    if guess_pool.length == 0
      leave("\e[41mYou LIAR!!!\e[0m")
    end

    # Guess a number
    guess = guess_pool.sample

    # Check if we've eliminated the possibilities and only have one option left.
    if guess_pool.length < 2
      puts "\e[42mI guessed it! I win!\e[0m\a"
      leave("The the correct number is #{guess_pool[0]}")
    end

    # Now that I've guessed, I need to know if I'm right or not.
    puts "My #{guess_num.ordinalize} guess: \e[1m#{guess}\e[0m"
    print "Am I correct, high, or low?: "
    response = gets.chomp!
    if (response == "low" && guess == 100) || (response == "high" && guess == 1)
      puts "\e[41mStop playin' with me\e[0m"
      next
    end

    # Based on the response, I'm going to modify my guess pool, and track
    # the guesses I've made so far.
    case response
    when "high"
      guess_pool.delete_if { |n| n > guess }
      guesses << guess
    when "low"
      guess_pool.delete_if { |n| n < guess }
      guesses << guess
    when "correct"
      puts "\e[42mComputers rule, humans drool.\e[0m"
      correct = true
    else
      puts "\e[41mWhat? You sassin' me?\e[0m"
    end

    # Remove the guess from the guess pool, and increment my guess count.
    guess_pool.delete(guess)
    guess_num = guesses.length + 1

  end

end
