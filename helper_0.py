import os
import sys
import re #regex

##############################helper functions########################################

args=sys.argv[1:]


def main(str0):
    line0=str0

    def printSwitch():
        #returns true to allow main to send out to a new readme
        regex_start=r"^##\s"
        regex_end=r"<br>"
        match_start=re.search(regex_start, line0)
        match_end=re.search(regex_end, line0)

        def getBranchName():
            regex1=r"(?<=:\s).*"
            branch_name=re.search(regex1,line0).group(0)
            return branch_name
        
        if match_start:
            return True, getBranchName()
        elif match_end:
            return False, 0
        else:
            return True, 0
        
    return " ".join(str(i) for i in printSwitch())

os.sys(f'echo {main(args)}')