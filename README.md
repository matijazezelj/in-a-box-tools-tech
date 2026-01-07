# In The Box - Website

Production-ready open source infrastructure stacks. One command. Zero complexity.

## Products

- **[OIB](https://github.com/matijazezelj/oib)** - Observability in a Box
- **[SIB](https://github.com/matijazezelj/sib)** - SIEM in a Box

## Local Development

### Prerequisites
- Ruby 2.7+
- Bundler

### Setup

```bash
# Install dependencies
bundle install

# Run local server
bundle exec jekyll serve
```

Open [http://localhost:4000](http://localhost:4000) in your browser.

### Build for production

```bash
bundle exec jekyll build
```

The site will be built to `_site/`.

## Deploying to GitHub Pages

1. Push to the `main` branch
2. Go to Settings → Pages
3. Select "Deploy from a branch" 
4. Choose `main` branch and `/ (root)` folder
5. Save

The site will be available at `https://yourusername.github.io/in-the-box-tech/`

### Custom Domain

To use a custom domain like `inthebox.tech`:

1. Add a `CNAME` file with your domain
2. Configure DNS to point to GitHub Pages
3. Enable HTTPS in repository settings

## Structure

```
.
├── _config.yml          # Site configuration
├── _layouts/            # Page templates
│   ├── default.html
│   ├── page.html
│   └── product.html
├── _includes/           # Reusable components
│   ├── header.html
│   └── footer.html
├── _products/           # Product pages (collection)
│   ├── oib.md
│   └── sib.md
├── assets/
│   ├── css/main.css     # Styles
│   ├── favicon.svg
│   └── images/          # Product screenshots
├── index.html           # Homepage
├── about.md             # About page
├── Gemfile              # Ruby dependencies
└── README.md
```

## Adding Screenshots

Place product screenshots in:
- `assets/images/oib/` - OIB screenshots
- `assets/images/sib/` - SIB screenshots

Recommended image sizes:
- Dashboard screenshots: 1200x800px
- Full-width images: 1600x900px

## License

MIT
