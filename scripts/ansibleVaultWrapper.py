import os
import sys
import subprocess

string = f"\'{sys.argv[1]}\'"

for handle in (sys.stdin, sys.stdout, sys.stderr):
    try:
        fd = handle.fileno()
        os.set_blocking(fd, True)
    except Exception:
        continue

subprocess.run(["ansible-vault", "encrypt_string", "--vault-password-file", "~/test-vault-pass", string])
