import os #
import sys
import json
import re #regex

args=" ".join(str(item) for item in sys.argv[1:])

def main(str0):
    line0=str0

    def printSwitch():
        #returns true to allow main to send out to a new readme
        start_regex=r"^##\s" #title pattern
        end_regex=r"<br>"
        file_regex=r"(?<=^#\s)\d{1,}"
        match_start=re.search(start_regex, line0)
        match_end=re.search(end_regex, line0)
        match_file=re.search(file_regex, line0)

        def getBranchName():
            #returns the title of the new branch name and next readme

            regex1=r'(?<=").*(?=")' #selects all that comes btn quotes
            branch_name=re.search(regex1,line0).group(0)
            branch_name=branch_name.replace(" ","-").lower()
            return branch_name
        
        def getFileName():
            with open(r"test\test.txt", "r") as test0:
                file_list=json.loads(test0.read())

            n=match_file.group(0)
            file_name="".join(file_list[n])
            return file_name
        
        if match_start:
            return True, getBranchName()
        elif match_end:
            return False, 0
        elif match_file:
            return False, getFileName()
        else:
            return True, 0
        
    return " ".join(str(i) for i in printSwitch())

os.system(f'echo {main(args)}')
