import os
import sys
import re #regex
##############################helper functions########################################

args=sys.argv[1:]

def printSwitch(line0):
    #returns true to allow main to send out to a new readme
    regex_start=r"^##\s"
    regex_end=r"<br>"
    match_start=re.search(regex_start, line0)
    match_end=re.search(regex_end, line0)
    
    if match_start:
        return True
    elif match_end:
        return False
    else 
    

def getBranchName(line1):
    branch_name=""
    print_switch=printSwitch(line1)

    if print_switch:
        regex1=r"(?<=:).*"
        branch_name=re.search(regex1,line1).group(0)
        return branch_name
    elif not print_switch:
        return 0








os.sys(f'echo {print_switch}')