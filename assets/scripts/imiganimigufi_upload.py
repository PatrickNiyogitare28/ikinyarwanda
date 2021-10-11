import random
import json
import math


# dictionary for imigani migufi
imigani = list()

# read file contains ibisakuzo, parse each line and put it into dictionary
try:
    with open("assets/imikino_files/imiganimigufi/imiganimigufi.txt", "rt", encoding='utf-8') as f:
        lines = f.read().split('\n\n')
        for l in lines:
            if l != '':
                imigani.append(l)
except:
    print("Error occured reading the file!")


numberOfDocs = math.floor(len(imigani) / 30)

# random number Id for games
randIds = list(range(1, numberOfDocs + 1))
random.shuffle(randIds)

random.shuffle(imigani)

index = 0


for gameNum in range(numberOfDocs):

    # write to file
    try:
        file_name = f"assets/imikino_json/imiganimigufi/{gameNum + 1}.json"
        with open(file_name, 'a', encoding='utf-8') as f:
            game_question = []

            game_id = {u'randomId': randIds[gameNum]}
            game_question.append(game_id)

            # generate 30 items for each game
            for n in range(30):

                question = {
                    u'umugani_%s' % (n + 1): imigani[index]
                }
                game_question.append(question)
                index = index + 1

            json.dump(game_question, f, ensure_ascii=False, indent=4)

    except:
        print('writing to file failed!')

    print(gameNum + 1, "Imigani migufi game success")
