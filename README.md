# Not Even Wrong

Personal blog about mathematics, algorithms, computer science, and the occasional
philosophy. Jekyll site with a custom Bootstrap 4-based theme, MathJax for math,
and Rouge for code highlighting.

## Running it

    docker compose up --build

Then open http://localhost:4000. Ctrl-C stops it; add `-d` to run in the
background. The container bind-mounts the repo and watches for changes, so
editing any file (except `_config.yml`, see below) auto-regenerates the site.

`_config.yml` changes need a restart to take effect:

    docker compose restart

## Writing a post

Add a file to `_posts/` named `YYYY-MM-DD-title-slug.md`, with front matter like:

    ---
    layout: post
    title: Post Title
    date: YYYY-MM-DD HH:MM
    categories: Mathematics
    ---

    Post content in Markdown. Inline math with `$...$`, display math with
    `$$...$$`. Fenced code blocks get syntax highlighting via Rouge.

`categories` groups posts on the homepage index — reuse an existing category
(Mathematics, Algorithms, ...) to add to it, or use a new one to start another
section. Drafts (no publish date needed yet) go in `_drafts/` instead and are
only built with `jekyll serve --drafts`.

## Configuration

`_config.yml` controls the site title/description, the author bio and
colophon shown in the footer, and which social icons appear in the navbar
(`github_username`, `linkedin_username`, `facebook_username` — leave a value
as `""` to hide that icon; `twitter_username` is set but currently unused).
Google Analytics is gated on `jekyll.environment == "production"`, so it
never fires during local `docker compose` runs.
