FROM thekitoinc/debian-python-pip:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install ffmpeg
RUN apt-get install ffmpeg -y
RUN apt-get install ffmpeg libsndfile1 -y

# Copy the current directory contents into the container at /app
WORKDIR /app
COPY . .

# Install git
RUN apt-get install git -y

# Install the required Python packages
RUN pip install --break-system-packages --no-cache-dir -r requirements.txt

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]