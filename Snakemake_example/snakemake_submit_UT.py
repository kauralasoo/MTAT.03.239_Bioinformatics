#!/usr/bin/env python
import os
import sys

from snakemake.utils import read_job_properties

#Extraxt job properties
jobscript = sys.argv[1]
job_properties = read_job_properties(jobscript)
print(job_properties)

# do something useful with the threads
threads = job_properties["threads"]
job_name = job_properties["rule"]

#Extract memory and construct memory string
mem = str(job_properties.get('resources',{}).get('mem'))

#Construct output file
output_file = os.path.join("SlurmOut", job_name + '.%j.txt')

#Construct a submission script
command = "".join(["sbatch -p main -J ", job_name, " -t 24:00:00 -N 1 --ntasks-per-node=1 --cpus-per-task=",
	str(threads), " --mem ", mem, " -o ", output_file, " -e ", output_file])

#Run the script
full_command = "{cmd} {script}".format(cmd = command, script=jobscript)
os.system(full_command)
