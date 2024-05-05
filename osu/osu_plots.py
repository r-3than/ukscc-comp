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

matplotlib.rcParams.update({'font.size': 22})

plt.plot(*unzip(latency["cn01,cn01"]), marker="o", label="cn01,cn01")
plt.plot(*unzip(latency["cn01,cn02"]), marker="o", label="cn01,cn02")
#plt.plot(*unzip(bandwidth["cn01,cn01"]), marker="o", label="cn01,cn01")
#plt.plot(*unzip(bandwidth["cn01,cn02"]), marker="o", label="cn01,cn02")
plt.tight_layout()
plt.yscale("log")
plt.xscale("log")
plt.subplots_adjust(left=0.1)
plt.xticks(unzip(bandwidth["cn01,cn01"])[0], unzip(bandwidth["cn01,cn01"])[0], rotation=45)
plt.xlabel("Transfer Size (B)")
plt.ylabel("Latency (μs)")
plt.grid()
plt.legend()
plt.show()