## Introduction

repo-organiser system is a lightweight command-line driven content parser.

It interprets specially formatted text lines and uses numbered file prefixes to map references to actual filenames.

It is designed to split contents in a repo using a structured markdown file.

The contents are split into different branches based on pattern matching.

## Getting Started

###	Software dependencies
1. Python
2. Windows 10 or Windows 11

###	Installation process
- Clone this repo

```
git clone https://github.com/14ag/repo-organizer
```
or
```
git clone https://dev.azure.com/muriukipn/repeatAttilery/_git/repo-organizer
```
- Asign variables in main.bat
    
    - `repo-path` is the path to the folder containing the repo

    - `readme` is a readme of each branch 

    - `long_readme` is a specificaly formatted repo readme file that represents the project to be split

- Run using `main.bat`




## Testing and debugging
* Set variable `repo-path` inside `main.bat` to `README0.md`.
* It is a specificaly formated markdown sample with the 4 types of inputs that are parsed by `helper_0.py`:
* comment out line 22: `call :out`
* on line 30 change `call :main` to `call :main0` to inspect variables

## Contribute
- Documentation
- Algorithm refinement
- Edge cases
