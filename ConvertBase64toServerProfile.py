import base64
import sys

base64_data = open(sys.argv[1], "r").read()

output_file = sys.argv[1].replace(".txt", ".png")

with open(output_file, "wb") as f:
    f.write(base64.b64decode(base64_data.strip()))