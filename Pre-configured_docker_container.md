# Pre-configured docker containers
I have now created a pre-configured docker image that has all of the necessary software installed. Once you have docker installed, you can download the image from DockerHub. Make sure that you have a fast Internet connection, because the file is over 5GB in size!

	docker pull kauralasoo/bioinfo_anaconda

It's a good practice to use docker only for the software and keep all of the data outside of the container. I prefer to have a local directory with all of the data that I mount to 

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2NDc0OTI1NzNdfQ==
-->