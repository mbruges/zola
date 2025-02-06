import json
def new_database():
    newDatabase = []
    missingBlurbs = 0
    with open('catalogue.json', 'r') as file:
        data = json.load(file)
        for entry in data[:300]:
            #print(json.dumps(entry, indent=4))
            try:
                title = str(entry['record']['245'][0]["a"][0]).replace("/","").strip()
                if title.endswith(" :"):
                    title = title[:-2]
            except (KeyError, IndexError):
                title = "UNKNOWN TITLE"

            try:
                author = str(entry['record']['245'][0]["c"][0])
                if author.endswith("."):
                    author = author[:-1]
            except (KeyError, IndexError):
                author = "UNKNOWN AUTHOR"

            try:
                blurb = str(entry['record']['520'][0]["a"][0])
                blurb = blurb.replace("--Provided by publisher.","")
                blurb = blurb.replace('"',"")
            except (KeyError, IndexError):
                blurb = "NONE"
                missingBlurbs += 1

            try:
                isbn = int(''.join(filter(str.isdigit, entry['record']['020'][0]["a"][0])))
            except (KeyError, IndexError, ValueError):
                isbn = 0

            tags = []
            try:
                for x in entry['record']['650']:
                    for i in x["a"]:
                        if "books" not in str(i) and str(i) not in str(tags):
                            tags.append(i)
            except (KeyError, IndexError):
                tags = []

            newData = {
                "title": title,
                "author": author,
                "blurb": blurb,
                "isbn": isbn,
                "tags": tags
            }
            newDatabase.append(newData)

    print("Missing blurbs: " + str(missingBlurbs))
    with open('new_database.json', 'w') as json_file:
            json.dump(newDatabase, json_file, indent=4)
