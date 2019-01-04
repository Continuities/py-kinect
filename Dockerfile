# Run on Ubuntu, because it has the best libfreenect support
FROM ubuntu:18.10

# Set the working directory to /home
WORKDIR /home

# Copy the current directory contents into the container at /app
COPY . /home

# Install all the dependencies
RUN apt-get update && apt-get install -y \
    freenect \
    python-dev \
    python-pip 
RUN pip install \
    cython \
    numpy
RUN python setup.py build_ext --inplace


# Make port 80 available to the world outside this container
#EXPOSE 80

# Define environment variable
#ENV NAME World

# Run app.py when the container launches
#CMD ["python", "app.py"]