# Pre-configured docker containers
I have now created a pre-configured docker image that has all of the necessary software installed. Once you have docker installed, you can download the image from DockerHub. Make sure that you have a fast Internet connection, because the file is over 5GB in size!

	docker pull kauralasoo/bioinfo_anaconda

It's a good practice to use docker only for the software and keep all of the data outside of the container. To achieve that, I prefer to have a local directory with all of the data that I mount to the container as a [data volume](https://rominirani.com/docker-tutorial-series-part-7-data-volumes-93073a1b5b72). You can do this when you create a container from the image using the `docker run` command:

	docker run -ti -v /Users/alasoo/projects/biocourse/:/biocourse:rw kauralasoo/bioinfo_anaconda bash

With this command, my local folder `/Users/alasoo/projects/biocourse/` is mounted into to container as `/biocourse`. Any files that I write into the `/biocourse` folder while I am running the container will be immediately visible in my own environment. 

Next, to be able to access all of the software that has been installed in container, you need to first activate the conda environment:

	source activate py3.6
After you have exited to container with the `exit` command, you can restart it with the following command: 

	docker start -ai <container_id>
You can find out your container id using the `docker ps -a` . **Do not try to restart the container with the `docker run` command! Instead of restarting your previous container, it will create a new container from the image that your provide.** 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTI4OTUyMDI0M119
-->