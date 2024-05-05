import subprocess
import itertools
import re
import json
from matplotlib import pyplot as plt
import matplotlib

def unzip(xss):
    return [ [ xs[i] for xs in xss ] for i in range(len(xss[0])) ]

with open("latency.json", "r") as f:
    latency = json.load(f)
with open("bandwidth.json", "r") as f:
    bandwidth = json.load(f)

nodes = set()
for k in latency.keys():
    nodes.update(k.split(","))

nodes = sorted(nodes)

rows = [
    [""] + [ "→" + x for x in nodes ]
]

for node1 in nodes:
    rows.append([node1 + "→"])
    for node2 in nodes:
        k = f"{node1},{node2}"
        rows[-1].append(str(max(unzip(bandwidth[k])[1])))

for row in rows:
    print(",".join(f"[{x}]" for x in row), end=",\n")