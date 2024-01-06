#!/bin/bash
#SBATCH --job-name=submit_blast_singul_pacioli-alumno31.sh
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno31/lab6/blast
#SBATCH --output=blast_output.txt
#SBATCH --error=blast_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load singularity

blast_container="/nas/hdd-0/singularity_images/blast_2.9.0--pl526h3066fca_4.sif"
output_file="results-blast.txt"
blast_dir="/home/alumno31/lab6/blast"
blast_db="zebrafish.1.protein.faa"
query_seq="P04156.fasta"

# Descomprimir la base de datos
gunzip -k ${blast_db}.gz

# Preparar la base de datos
makeblastdb_path_inside_container=$(singularity exec ${blast_container} which mhich makeblastdb)
singularity exec ${blast_container} ${makeblastdb_path_inside_container} -in ${blast_db} -dbtype prot

# Alineación
singularity exec ${blast_container} blastp -query ${query_seq} -db ${blast_db} -out ${output_file}

module unload singularity

# Actividad extra: Generar un informe de variantes
grep -E '^>' ${output_file} | awk '{print $1, $3}' > "${variant_report}"

