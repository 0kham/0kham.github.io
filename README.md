# My blog and personal homepage

Somewhere where I write about algorithms and mathematics


## to build
docker build -t my-blog .

## to run
docker run --rm -p 4000:4000 -v $(pwd):/srv/jekyll my-blog

