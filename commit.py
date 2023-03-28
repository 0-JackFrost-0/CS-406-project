import sys
import subprocess
from sha1 import sha1sum

def main():
    changes = []
    with open('.repo/index.i') as stage:
        for line in stage:
            changes.append(line.split("\n")[0])
    # print(sys.argv[1])
    for change in changes:
        checksum = sha1sum(change)
        if 
    # print(changes)

if __name__ == '__main__':
    main()
