import random
import re
import json


def parseline(l):
    a = re.split("[-:]", l)
    dictionary = dict()
    dictionary[a[0].strip()] = a[1].strip()
    return dictionary


# dictionary for incamarenga
incamarenga = dict()


# read file contains incamarenga, parse each line and put it into dictionary
try:
    with open("assets/imikino_files/incamarenga/incamarengafromwiki.txt", "rt", encoding='utf-8') as f:
        lines = f.read().split('\n\n')
        for l in lines:
            if l != '':
                incamarenga.update(parseline(l))
except:
    print("Failed to read the file!")

# shuffle the order
iks = list(incamarenga.keys())
random.shuffle(iks)

# write to file
try:
    file_name = f"assets/imikino_json/incamarenga/incamarenga.json"
    with open(file_name, 'a', encoding='utf-8') as f:
        game_question = []

        # generate 20 items for each game
        for n in range(20):

            # the correct answer for each question
            igisobanuro = incamarenga[iks[n]]
            question = {
                u'incamarenga_%s' % (n + 1): {
                    u'incamarenga': iks[n].capitalize(),
                    u'igisobanuro': igisobanuro.capitalize(),
                }
            }
            game_question.append(question)

        json.dump(game_question, f, ensure_ascii=False, indent=4)

except:
    print('writing to file failed!')

print(n + 1, "incamarenga success")
