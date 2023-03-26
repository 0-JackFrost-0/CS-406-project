import sys
import os


def main():
    changes = []
    with open('.repo/index.i') as stage:
        for line in stage:
            changes.append(line.split("\n")[0])
    print(changes)
if __name__ == '__main__':
    main()
