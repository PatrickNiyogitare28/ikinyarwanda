import random
import re
import json


def parseline(l):
    a = re.split("[-:]", l)
    parsed = dict()
    parsed[a[0].strip()] = a[1].strip()
    return parsed


# dictionary of ibisakuzo
ibisakuzo = dict()

# read file contains ibisakuzo, parse each line and put it into dictionary
try:
    with open("assets/imikino_files/ibisakuzo/ibisakuzolevel2.txt", "rt", encoding='utf-8') as f:
        lines = f.read().split('\n\n')
        for l in lines:
            if l != '':
                ibisakuzo.update(parseline(l))
except:
    print("Failed to read the file!")

# number of games to generate
numberOfGames = 800

# random number Id for games
randIds = list(range(1, numberOfGames + 1))
random.shuffle(randIds)

for gameNum in range(numberOfGames):

    # shuffle the order of ibisakuzo
    ibs = list(ibisakuzo.keys())
    random.shuffle(ibs)

    # write to file
    try:
        file_name = f"assets/imikino_json/ibisakuzo_2/{gameNum + 1}.json"
        with open(file_name, 'a', encoding='utf-8') as f:
            game_question = []

            game_id = {u'randomId': randIds[gameNum]}
            game_question.append(game_id)

            # generate 10 random ibisakuzo and answers
            for n in range(10):
                correct_answer = ibisakuzo[ibs[n]]
                wrong_answers = list(ibisakuzo.values())
                del wrong_answers[wrong_answers.index(correct_answer)]
                wrong_answers = random.sample(wrong_answers, 3)
                answer_options = wrong_answers + [correct_answer]
                random.shuffle(answer_options)

                question = {
                    u'sakwe_%s' % (n + 1): {
                        u'question': ibs[n],
                        u'option_1': (answer_options[0]).capitalize(),
                        u'option_2': answer_options[1].capitalize(),
                        u'option_3': answer_options[2].capitalize(),
                        u'option_4': answer_options[3].capitalize(),
                        u'correct_answer': correct_answer.capitalize(),
                    }
                }
                game_question.append(question)

            json.dump(game_question, f, ensure_ascii=False, indent=4)

    except:
        print('writing to file failed!')

    print(gameNum + 1, "SakweSakwe game success")
