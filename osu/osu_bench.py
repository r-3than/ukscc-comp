import subprocess
import itertools
import re
import json

nodes = [f"cn{x+1:02}" for x in range(4)]

def parse_stdout(s: bytes):
    pairs = []
    for line in s.decode("utf-8").splitlines():
        if mat := re.match(r"(\d+)\s+(\d+\.\d+)", line):
            size, bw = mat.groups()
            pairs.append((int(size), float(bw)))
    return pairs

latency = {}
bandwidth = {}
for n1, n2 in itertools.product(nodes, nodes):
    print(n1, n2)
    if n1 != n2: job_conf = ["salloc", f"--nodelist={n1},{n2}", "--ntasks-per-node=1"]
    else: job_conf =  ["salloc", f"--nodelist={n1}", "--ntasks-per-node=2"]
    latency[f"{n1},{n2}"] = parse_stdout(subprocess.run(job_conf + ["mpirun", "./c/mpi/pt2pt/standard/osu_latency"], capture_output=True).stdout)
    bandwidth[f"{n1},{n2}"] = parse_stdout(subprocess.run(job_conf + ["mpirun", "./c/mpi/pt2pt/standard/osu_bw"], capture_output=True).stdout)

with open("latency.json", "w") as f:
    json.dump(latency, f)
with open("bandwidth.json", "w") as f:
    json.dump(bandwidth, f)