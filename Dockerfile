# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Update the package lists and install Apache2
RUN apt-get update && apt-get install -y apache2

# Copy the content of the app from the local machine to /var/www/html
COPY . /var/www/html

# Expose port 80 for Apache2
EXPOSE 80

# Start Apache2 when the container launches
CMD ["apache2ctl", "-D", "FOREGROUND"]
