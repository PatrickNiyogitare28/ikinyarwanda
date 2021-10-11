import random
import re
import json


def parseline(l):
    a = re.split("[-:]", l)
    dictionary = dict()
    dictionary[a[0].strip()] = a[1].strip()
    return dictionary


# dictionary for ikeshamvugo
ikeshamvugo = dict()

# read file contains ibisakuzo, parse each line and put it into dictionary
try:
    with open("assets/imikino_files/ikeshamvugo/all_ntibavuga_bavuga.txt", "rt", encoding='utf-8') as f:
        lines = f.read().split('\n\n')
        for l in lines:
            if l != '':
                ikeshamvugo.update(parseline(l))
except:
    print("Failed to read the file!")

# number of games to generate
numberOfGames = 30

# random number Id for games
randIds = list(range(1, numberOfGames + 1))
random.shuffle(randIds)

for gameNum in range(numberOfGames):

    # shuffle the order
    iks = list(ikeshamvugo.keys())
    random.shuffle(iks)

    # write to file
    try:
        file_name = f"assets/imikino_json/ikeshamvugo/{gameNum + 1}.json"
        with open(file_name, 'a', encoding='utf-8') as f:
            game_question = []

            game_id = {u'randomId': randIds[gameNum]}
            game_question.append(game_id)

            # generate 20 items for each game
            for n in range(20):

                # the correct answer for each question
                correct_answer = ikeshamvugo[iks[n]]

                question = {
                    u'ntibavuga_%s' % (n + 1): {
                        u'question': iks[n].capitalize(),
                        u'answer': correct_answer.capitalize(),
                    }
                }
                game_question.append(question)

            json.dump(game_question, f, ensure_ascii=False, indent=4)

    except:
        print('writing to file failed!')

    print(gameNum + 1, "Ntibavuga bavuga game success")
