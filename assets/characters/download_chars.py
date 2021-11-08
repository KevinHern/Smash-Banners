import requests
import os
from multiprocessing import Process, Lock, Manager
import numpy as np


# img_data = requests.get('https://www.smashbros.com/assets_v2/img/fighter/pyra/main2.png').content
# print(img_data)

def download(characters_list, process_id):
    for character in characters_list:
        directory = None
        if (character == "Donkey Kong") or (character == "Dark Samus") or (character == "Captain Falcon") or (
                character == "Ice Climbers") or (character == "Young Link") or (character == "Meta Knight") or (
                character == "Dark Pit") or (character == "Zero Suit Samus") or (character == "Diddy Kong") or (
                character == "Pokemon Trainer") or (character == "King Dedede") or (character == "Toon Link") or (
                character == "Mega Man") or (character == "Wii Fit Trainer") or (character == "Little Mac") or (
                character == "Duck Hunt") or (character == "Piranha Plant"):
            directory = character.lower().replace(" ", "_")
        elif (character == "Dr. Mario") or (character == "R.O.B.") or (character == "Bowser Jr.") or (
                character == "King K. Rool"):
            directory = character.lower().replace(" ", "_").replace(".", "")
        elif character == "Mr. Game & Watch":
            directory = character.lower().replace(" ", "_").replace(".", "").replace("&", "and")
        elif (character == "Mii Brawler") or (character == "Mii Swordfighter") or (character == "Mii Gunner"):
            directory == 'mii_fighter'
        elif character == "Pac-Man":
            directory = character.lower().replace("-", "_")
        elif character == "Min Min":
            directory = character.lower().replace(" ", "")
        elif character == "Hero":
            directory = "dq_hero"
        elif character == "Pyra & Mythra":
            directory = "pyra"
        else:
            directory = character.lower()

        fighter_directory = os.path.join(os.getcwd(), directory)
        os.makedirs(fighter_directory, exist_ok=True)

        smash_server_link = "https://www.smashbros.com/assets_v2/img/fighter/"
        alts = [i+1 for i in range(8)]

        for alt in alts:
            print("Process #" + str(process_id) + ": " + "Downloading " + character + "'s alt number " + str(alt))
            image_to_fetch = 'main' + ("" if alt == 1 else str(alt)) + '.png'

            response = requests.get(smash_server_link + directory + "/" + image_to_fetch, timeout=5)
            with open(os.path.join(fighter_directory, image_to_fetch), 'wb') as handler:
                handler.write(response.content)

            response.close()

            if directory == "mii_fighter":
                break

if __name__ == "__main__":
    charactersList = [
        #"Mario",
        "Donkey Kong",
        #"Link",
        #"Samus",
        #"Dark Samus",
        #"Yoshi",
        #"Kirby",
        #"Fox",
        #"Pikachu",
        #"Luigi",
        #"Ness",
        #"Captain Falcon",
        #"Jigglypuff",
        #"Peach",
        #"Daisy",
        #"Bowser",
        #"Ice Climbers",
        #"Sheik",
        #"Zelda",
        #"Dr. Mario",
        #"Pichu",
        #"Falco",
        #"Marth",
        #"Lucina",
        #"Young Link",
        #"Ganondorf",
        #"Mewtwo",
        #"Roy",
        #"Chrom",
        #"Mr. Game & Watch",
        #"Meta Knight",
        #"Pit",
        #"Dark Pit",
        #"Zero Suit Samus",
        #"Wario",
        #"Snake",
        #"Ike",
        #"Pokemon Trainer",
        #"Diddy Kong",
        #"Lucas",
        #"Sonic",
        #"King Dedede",
        #"Olimar",
        #"Lucario",
        #"R.O.B.",
        #"Toon Link",
        #"Wolf",
        #"Villager",
        #"Mega Man",
        #"Wii Fit Trainer",
        #"Rosalina & Luma",
        #"Little Mac",
        #"Greninja",
        #"Mii Brawler",
        #"Mii Swordfighter",
        #"Mii Gunner",
        #"Palutena",
        #"Pac-Man",
        #"Robin",
        #"Shulk",
        #"Bowser Jr.",
        #"Duck Hunt",
        #"Ryu",
        #"Ken",
        #"Cloud",
        #"Corrin",
        #"Bayonetta",
        #"Inkling",
        #"Ridley",
        #"Simon",
        #"Richter",
        #"King K. Rool",
        #"Isabelle",
        #"Incineroar",
        #"Piranha Plant",
        #"Joker",
        #"Hero",
        #"Banjo & Kazooie",
        #"Terry",
        #"Byleth",
        #"Min Min",
        #"Steve",
        #"Sephiroth",
        #"Pyra & Mythra",
        #"Kazuya",
        #"Sora"
    ]

    processes = []
    num_threads = 2
    chunks = np.array_split(charactersList, num_threads)

    # Create the N threads
    for i in range(num_threads):
        process = Process(target=download, args=[chunks[i], i])
        process.start()
        processes.append(process)

    for process in processes:
        process.join()
