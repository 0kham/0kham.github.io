# Use the Jekyll image, compatible with ARM architecture
FROM jekyll/jekyll:4.2.0

# Set the working directory inside the container
WORKDIR /srv/jekyll

# Copy the current directory contents to the container
COPY . .

# Grant write permissions to the /srv/jekyll directory and all its contents
RUN chmod -R 777 /srv/jekyll

# Install bundle dependencies
RUN bundle install

# Expose the port Jekyll will run on
EXPOSE 4000

# Default command to serve the site
CMD ["jekyll", "serve", "--host", "0.0.0.0"]


## to build
# docker build -t my-blog .

## to run
# docker run --rm -p 4000:4000 -v $(pwd):/srv/jekyll my-blog