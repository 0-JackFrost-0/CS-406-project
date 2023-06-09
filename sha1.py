import sys
import hashlib

def sha1sum(filename):
# BUF_SIZE is totally arbitrary, change for your app!
    BUF_SIZE = 65536  # lets read stuff in 64kb chunks!

    # md5 = hashlib.md5()
    sha1 = hashlib.sha1()

    with open(filename, 'rb') as f:
        while True:
            data = f.read(BUF_SIZE)
            if not data:
                break
            # md5.update(data)
            sha1.update(data)

    # print("MD5: {0}".format(md5.hexdigest()))
    return sha1.hexdigest()
    # print("SHA1: {0}".format(sha1.hexdigest()))

if __name__ == '__main__':
    sha1sum(sys.argv[1])