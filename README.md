# Docker Image with OpenFoam and Paraview (with GUI)

# Build the docker images

From the project folder, run the command below:

```bash build.sh```

# Run docker container

## Standard approach (recommended)

From the project folder, run the command below:

```docker-compose up```

## Alternative approach

You can run the following command:

```docker run -it -d -p 3000:3000 gnasello/ofpv-env:latest```

# Use the Docker container

Open ```localhost:3000``` in your browser to get a virtual desktop.