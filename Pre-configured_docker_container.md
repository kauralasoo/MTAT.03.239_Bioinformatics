# Pre-configured docker containers
I have now created a pre-configured docker image that has all of the necessary software installed. Once you have docker installed, you can download the image from DockerHub. Make sure that you have a fast Internet connection, because the file is over 5GB in size!

	docker pull kauralasoo/bioinfo_anaconda

It's a good practice to use docker only for the software and keep all of the data outside of the container. To achieve that, I prefer to have a local directory with all of the data that I mount to the container as a data volume. You can do this when you create a container from the image using the `docker run` command:

	docker run -ti -v /Users/alasoo/projects/biocourse/:/biocourse:rw kauralasoo/bioinfo_anaconda bash

With this command, my local folder `/Users/alasoo/projects/biocourse/` is mounted into to container as `/biocourse`. Any files that I write into the `/biocourse` folder from the container will be immediately visible in my own environment. 

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIwNDcwOTAyODldfQ==
-->