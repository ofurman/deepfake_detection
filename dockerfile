# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies needed for FFmpeg and OpenCV
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --fix-missing build-essential  
RUN apt-get install -y --fix-missing cmake
RUN apt-get install -y --fix-missing ffmpeg
RUN apt-get install -y --fix-missing libopencv-dev
RUN rm -rf /var/lib/apt/lists/*

# Upgrade pip to its latest version
RUN pip install --upgrade pip

# Copy the current directory contents into the container at /usr/src/app
COPY . /usr/src/app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --editable av_hubert/fairseq

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

RUN /bin/bash