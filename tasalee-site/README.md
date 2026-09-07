# tasalee.online

The public client site for Tasalee Property Assurance, served by GitHub Pages
at https://tasalee.online

    index.html    the whole site, one file
    404.html      the not found page
    img/          the photographs, the share card and the report thumbnails
    reports/      the two sample health cards, linked from the site
    CNAME         the custom domain, required by GitHub Pages
    .nojekyll     stops Jekyll processing, which we do not use
    robots.txt    crawl rules
    sitemap.xml   one URL, the front page

No build step, no framework, no dependencies, no server. The page makes one
external request, for two typefaces from Google Fonts. Everything else,
including all the CSS and JavaScript, ships inside `index.html`.

## Changing something

Small edits go straight into `index.html`. Content is plain HTML in the body,
styles are one CSS block at the top, behaviour is one script block at the
bottom. Search for the words you want to change and type over them. Commit and
push, and GitHub rebuilds in about a minute.

Larger changes are made in the source pieces, which live outside this
repository: `site_head.html`, `site_body.html`, `site_js.html`,
`site_grade.css` and `tasalee.css`, assembled by `make_deploy.py`.

## The photographs

Every picture passes through a grade in the page itself, a desaturating colour
pass, a translucent navy tint and a vignette. That is what makes a stock
photograph, a generated frame and a phone snap look like one company. Source
files go through `grade.py` first. The prompts, the sourcing rules and the per
slot controls are in `IMAGE_PROMPTS.md`.

`img/report-health-card.jpg` is not a photograph. It is a render of two real
pages of the premium health card, built by `report_tile.py`. Regenerate it when
the report design changes.

## Enquiries

The contact form posts to FormSubmit, which relays it as an email to
`tasalee.support@gmail.com` with the sender's own address set as reply to, so
answering in that inbox answers the client. No server of ours is involved.

The first submission from a new domain sends an activation link to that inbox.
Open it once, click the link, and the form is live for good. After that you can
swap `LEAD_TO` in `index.html` for the hashed token FormSubmit gives you, which
keeps the address out of the page source.

If the relay is ever unreachable the form falls through to WhatsApp, so an
enquiry is never silently lost.

## The sample reports

`reports/` holds the two real health cards the site links to, the free screen
and the premium file. Their cover thumbnails in `img/` are rendered from the
PDFs by the same script that builds the report tile. Regenerate all three
whenever the report design changes.

## What is not here

The operations console. It names our sources, our method, our limits and what
is not built yet, and this repository is public. It is not published.
