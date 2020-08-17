class Hangman

    def initialize()

        @turn = 0

        @word = nil

        @saved_game = []

        @current_guess = nil

        @id = 0

    end

    def save_game(id)

        Dir.mkdir("saved_games") unless Dir.exists? "saved_games"

        filename = "saved_games/#{id}"

        File.open(filename, 'w') do |file|

            puts @word

            puts @current_guess

            puts @turn
        
        end

    end 

    def game

        puts "Do you want to start a new game or load a saved gamed? Type new or saved."

        response = gets.chomp

        answer = handle_answer(response)

        if response == "new"

            @turn = 0

            @word = get_word()

        else

            puts Dir["./saved_games"]

            puts "Which file would you like to load?"

            id = gets.chomp

            number = handle_filenumber(id)

        end

        puts @word

    end

    def handle_answer(response)

        response = response.downcase

        while response != "new" && response != "saved"

            puts "Please type new or saved."

            response = gets.chomp

        end

    end

    def handle_filenumber(id)

        if Dir["./saved_games{#{id}"].exists?

            File.open("./saved_games#{id}", "r") do |file|

                file.readlines.each_with_index do |line, idx|

                    if idx == 0

                        @word = line

                    elsif idx == 1

                        @current_guess = line

                    else

                        @turn == line

                    end

                end

            end

        else

            id = gets.chomp

            puts "Please select from the list provided."

            handle_filenumber(id)

        end

    end

    def get_word

        list = IO.readlines("5desk.txt")

        word = list[rand(list.size)]

        while word.length < 5 || word.length > 12

            word = list[rand(list.size)]

        end

        word

    end

end

hangman = Hangman.new()

hangman.game









        


