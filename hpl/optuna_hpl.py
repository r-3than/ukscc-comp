import optuna
import subprocess

def objective(trial):
    p_log = trial.suggest_int("log2 P", 0, 2) # 1 to 4
    p = 2 ** p_log
    q = 4 // p
    block = trial.suggest_int("NB", 64, 256, step=64)
    bcast = trial.suggest_categorical("BCAST", ["0", "1", "2", "3", "4", "5"])
    with open("HPL.dat", "w") as f:
        f.write(f"""HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any)
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
32768        Ns
1            # of NBs
{block}           NBs
0            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
{p}             Ps
{q}             Qs
16.0         threshold
1            # of panel fact
2            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterium
4            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
1            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
{bcast}          BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
1            DEPTHs (>=0)
2            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
##### This line (no. 32) is ignored (it serves as a separator). ######
0                               Number of additional problem sizes for PTRANS
1200 10000 30000                values of N
0                               number of additional blocking sizes for PTRANS
40 9 8 13 13 20 16 32 64        values of NB""")
    proc = subprocess.run(["mpirun", "-x", "OMP_NUM_THREADS=16", "--map-by", "node:PE=16", "./xhpl"], capture_output=True)
    proc.check_returncode()
    ctr = 0
    for line in proc.stdout.splitlines():
        if ctr == 2:
            gflops = float(line.decode("utf-8").split()[-1])
            break
        if line == b"T/V                N    NB     P     Q               Time                 Gflops":
            ctr = 1
        if line == b"--------------------------------------------------------------------------------" and ctr == 1:
            ctr = 2

    assert gflops
    print(gflops)
    return gflops

study = optuna.create_study(direction="maximize", storage="sqlite:///db.sqlite3", study_name="hpl-omp-real-3", load_if_exists=True)
study.optimize(objective, n_trials=64)

print(study.best_params, study.best_value)
