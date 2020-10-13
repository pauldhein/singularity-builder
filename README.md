# singularity-builder
A repo that holds the Dockerfile necessary to create a Docker image that can be used to build Singularity Containers

## Container creation instructions
  1. Build the docker container using the command: `docker build -t <tag-name> .`
  2. Run the docker container with the singularity build command and a mount point to the directory on your local machine that contains your singularity recipe file. This directory will also be the location of your generated singularity image file.

  `docker run --mount type=bind,source=<path-to-local-folder>,target=/tmp/sing-files <tag-name> singularity build <singularity-image-name>.simg <singularity-recipe-name>.def`
