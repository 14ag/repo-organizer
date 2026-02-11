#builds a key value db of files in folder
import json
import os
import sys

args=r" ".join(str(item) for item in sys.argv[1:])

file_list_data={}
working_directory=args


files_fetched=os.listdir(working_directory)

for file in files_fetched:
    file_list_data[file[:2].strip("_")]=file

with open("file_list.json", "w") as file_list_json:
    file_list_json.write(json.dumps(file_list_data))

os.system("echo file_list.json created")
