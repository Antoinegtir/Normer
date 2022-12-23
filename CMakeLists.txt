cmake_minimum_required(VERSION 3.10)

# Define the target for building the Docker image
add_custom_target(build-docker
  # Build the Docker image
  COMMAND docker build -t my-bash-image .
  # Set the working directory to the root of the project
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  # Specify that the target depends on the Dockerfile
  DEPENDS Dockerfile
)

# Define the target for running the Bash script inside the Docker container
add_custom_target(run-bash-script
  # Run the Bash script inside the Docker container
  COMMAND docker run --rm my-bash-image bash normz.sh
  # Set the working directory to the root of the project
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  # Specify that the target depends on the build-docker target
  DEPENDS build-docker
)
