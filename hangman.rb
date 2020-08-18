class Hangman

    def initialize()

        @misses = 0

        @word = nil

        @guesses = @guesses || []

        @id = 0

    end

    def save_game(id)

        Dir.mkdir("saved_games") unless Dir.exists? "saved_games"

        filename = "saved_games/#{id}"

        File.open(filename, 'w') do |file|

            file.puts @word

            file.print @guesses

            file.puts

            file.puts @misses
        
        end

    end 

    def game

        puts "Do you want to start a new game or load a saved gamed? Type new or saved."

        response = gets.chomp

        answer = handle_answer(response)

        if response == "new"

            @misses = 0

            @word = get_word()

            @id += 1

        else

            load_games = Dir.open "./saved_games"

            load_games.each{ |s| puts s}

            puts "Which file would you like to load?"

            id = gets.chomp

            number = handle_filenumber(id)

        end

        puts @word

        guessing = true

        while guessing

            p @guesses

            choice = valid_choice

            if choice == "save"

                break

            end

            @guesses << choice

            hint = ""

            count_missed = 0

            @word.split('').each do |letter| 
                
                if @guesses.include? letter 
                    
                    hint.concat("#{letter} ")

                else
                    
                    hint.concat("_ ") 

                    count_missed += 1

                end

            end

            if !@word.include? choice

                @misses += 1

                puts "Sorry that letter is not in the word! You've missed #{@misses} guesses so far."

            end

            puts "\n #{hint} \n"

            if count_missed == 0

                puts "You guessed the word!"

                guessing = false

            end

            if @misses > 5

                guessing = false

                puts "Sorry you ran out of guesses! The answer was #{@word}"

            end

        end

    end

    def handle_answer(response)

        response = response.downcase

        while response != "new" && response != "saved"

            puts "Please type new or saved."

            response = gets.chomp

        end

    end

    def handle_filenumber(id)

        Dir.chdir "./saved_games"

        if File.exists? id 

            File.open(id, "r") do |file|

                file.readlines.each_with_index do |line, idx|

                    if idx == 0

                        @word = line.chomp

                    elsif idx == 1

                        @guesses = Kernel.eval(line)

                    else

                        @misses = line.to_i

                    end

                end

            end

        Dir.chdir ".."

        else

            puts "Please select from the list provided."

            id = gets.chomp

            handle_filenumber(id)

        end

    end

    def get_word

        list = IO.readlines("5desk.txt")

        word = list[rand(list.size)].chomp

        while word.length < 5 || word.length > 12

            word = list[rand(list.size)].chomp

        end

        word

    end

    def valid_choice

        puts "What letter would you like to guess? If you woul like to save type save."

        option = gets.chomp

        if option.length == 1

            option

        elsif option == "save"

            save_game(@id)

            "save"

        else

            puts "Please put in a one letter guess."

            valid_choice()

        end

    end

end

hangman = Hangman.new()

hangman.game









        


