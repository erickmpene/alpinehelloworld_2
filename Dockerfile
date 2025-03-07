#Grab the latest alpine image
FROM alpine:latest

# Install python and pip
RUN apk add --no-cache python3 py3-pip bash
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

EXPOSE 5000 		

# Run the image as a non-root user
RUN adduser -D toto
USER toto

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:5000 wsgi 

