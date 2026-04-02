# Apptainer Container for IG Publisher on postproc-g

Run the full IG Publisher build on NIST's postproc-g HPC system using Apptainer.

## One-Time Setup

### 1. Build the container image

On a system with Apptainer (or on postproc-g itself if `apptainer build` is available):

```bash
cd apptainer/
apptainer build ig-publisher.sif ig-publisher.def
```

This produces `ig-publisher.sif` (~1-2 GB). Takes 10-15 minutes.

If postproc-g doesn't allow `apptainer build`, build on your Mac (requires
Apptainer or a Linux VM) and scp the .sif up:

```bash
scp ig-publisher.sif postproc-g.nist.gov:~/ig-publisher.sif
```

### 2. Initial project sync

```bash
# From the project root on your Mac:
rsync -avz --exclude='.git' --exclude='output' --exclude='temp' --exclude='template' \
    ./ postproc-g.nist.gov:~/v2ig/
```

## Running the IG Publisher

```bash
ssh postproc-g.nist.gov

cd ~/v2ig

# Subset build (~20 resources, fast)
apptainer exec ~/ig-publisher.sif \
    java -jar input-cache/publisher.jar -ig ig.ini -no-sushi

# Full build (~1,700 resources — use the big heap)
apptainer exec ~/ig-publisher.sif \
    java -Xmx64g -jar input-cache/publisher.jar -ig ig-full.ini -no-sushi
```

Note: With 128 cores and 1TB RAM on postproc-g, you can use `-Xmx64g` or more.
The IG Publisher is mostly single-threaded but the extra heap prevents GC pauses.

## Getting Output Back

```bash
# From your Mac:
rsync -avz postproc-g.nist.gov:~/v2ig/output/ ./output/
```

## Notes

- Apptainer bind-mounts your home directory by default, so `~/v2ig` is
  accessible inside the container without extra flags.
- The container has Java 17, Ruby 3.2, Jekyll, Asciidoctor, and python-docx.
- The .sif image is immutable — rebuild it only when dependencies change.
