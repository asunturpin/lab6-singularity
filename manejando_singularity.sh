#!/bin/bash


#1
echo "Ejecución comando hostname en ibsen"
hostname

echo "Ejecución en el contenedor my-python.sif de Singularity"
singularity_dir="/home/alumno31/lab6/singularity"
singularity_container="${singularity_dir}/my-python.sif"
singularity exec "${singularity_container}" hostname

#2
echo "Ejecución cat /etc/os-release en ibsen"
cat /etc/os-release
echo "Ejecución cat /etc/os-release en el contenedor my-python.sif de Singularity"
singularity exec "${singularity_container}" cat /etc/os-release

#3
echo "Ejecución pwd en ibsen"
pwd
echo "Ejecución pwd en el contenedor my-python.sif de Singularity"
singularity exec "${singularity_container}" pwd

#4
echo "Ejecución ls -l /home en ibsen"
ls -l /home
echo "Ejecucion ls -l /home en el contenedor my-python.sif de Singularity"
singularity exec "${singularity_container}" ls -l /home

#5
echo "Ejecución python --version en ibsen"
python --version
echo "Ejecución python --version en el contenedor my-python.sif de Singularity"
singularity exec "${singularity_container}" python --version

#6
#echo "Ejecución notebook py.ipynb 10**5 desde source"
pip install numba
singularity exec "${singularity_container}" pip install numba
singularity exec "${singularity_container}" jupyter nbconvert --to notebook --execute source/pi.ipynb --ExecutePreprocessor.timeout=600 --output result_ibsen.ipynb
echo "Ejecución notebook py.ipynb 10**5 desde el contenedor my-python.sif"
singularity exec "${singularity_container}" bash -c "cd /home/alumno31/ && pwd"
singularity exec "${singularity_container}" jupyter nbconvert --to notebook --execute /app/pi.ipynb --ExecutePreprocessor.timeout=600 --output /home/alumno31/lab6/result_singularity.ipynb

