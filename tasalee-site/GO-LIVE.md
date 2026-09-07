# Putting tasalee.online live

The repository is built and committed. What is left needs your GitHub account
and your Hostinger account, so those steps are yours. Everything else is done.

I could not do the account steps myself: I do not sign in to your accounts or
handle your credentials, and this session has no authenticated path to
`github.com/shubhammalik1684`. The three commands below run under your own
login on your own machine, which is the right way round anyway.

Right now `tasalee.online` and `www.tasalee.online` both resolve to
`2.57.91.91`, which is Hostinger's parking page. Those are the records you will
replace.

---

## Step 1, push the repository

The folder `repo/` in the bundle is a complete git repository with one commit
already made. Unzip it, rename it if you like, and from inside it run:

```bash
git remote add origin https://github.com/shubhammalik1684/tasalee-site.git
git push -u origin main
```

Create the repository on GitHub first, at
`https://github.com/new`, named **tasalee-site**, **Public**, and with
**no** README, .gitignore or licence, because the folder already has its own
history and an empty repository avoids a merge on the first push.

It has to be public. GitHub Pages on a free account only serves public
repositories. That is fine for this site, which is meant to be read by anyone,
and it is exactly why the console is not going anywhere near it. More on that
at the end.

## Step 2, turn Pages on

In the repository: **Settings → Pages**.

- Source: **Deploy from a branch**
- Branch: **main**, folder **/ (root)**
- Save

Wait about a minute. It will publish at
`https://shubhammalik1684.github.io/tasalee-site/` first. Ignore that address,
it is only a staging step, and some images will look wrong there because the
page expects to sit at a domain root.

The **Custom domain** box on the same page: type `tasalee.online` and save.
The repository already contains a `CNAME` file with that name, so this should
fill itself in; if it does, leave it alone.

## Step 3, the DNS records at Hostinger

**hPanel → Domains → DNS → tasalee.online → DNS records.**

**First delete** every existing `A` record for `@` and the `A` or `CNAME` for
`www`. Those point at the parking page and they will fight the new ones. The
trash icon on the right of each row.

**Then add these eight records.** Name field, Points to / Content field.

| Type | Name | Points to | TTL |
|---|---|---|---|
| A | @ | 185.199.108.153 | 3600 |
| A | @ | 185.199.109.153 | 3600 |
| A | @ | 185.199.110.153 | 3600 |
| A | @ | 185.199.111.153 | 3600 |
| AAAA | @ | 2606:50c0:8000::153 | 3600 |
| AAAA | @ | 2606:50c0:8001::153 | 3600 |
| AAAA | @ | 2606:50c0:8002::153 | 3600 |
| AAAA | @ | 2606:50c0:8003::153 | 3600 |

**And one more,** so that `www.tasalee.online` also works:

| Type | Name | Points to | TTL |
|---|---|---|---|
| CNAME | www | shubhammalik1684.github.io | 3600 |

Note the trailing dot Hostinger may add to the CNAME target. That is normal.
Do not put the repository name in it. Do not put `https://` in front of it.

Leave your MX records alone if you have email on this domain. These changes
touch web traffic only.

Give it fifteen minutes. It can take up to 24 hours but rarely does.

## Step 4, HTTPS

Go back to **Settings → Pages**. Once GitHub has verified the DNS, an
**Enforce HTTPS** checkbox becomes available. Tick it. GitHub issues a free
certificate through Let's Encrypt and renews it forever.

It may say "unavailable for your site" for a few hours while the certificate is
issued. That is normal, come back later. Do not launch on plain `http`. A due
diligence firm on an unencrypted site answers its own question.

## Step 5, check it

```bash
curl -sI https://tasalee.online | head -3
curl -sI https://www.tasalee.online | head -3
```

Both should return `HTTP/2 200`. Then open it on a phone, and paste the link
into WhatsApp to yourself to confirm the share card appears. That card is
`img/share.jpg`, already built and already wired into the page.

---

## What is already handled

You do not need to do anything about these, they are in the repository.

- `CNAME` with `tasalee.online`, which Pages requires and which survives
  rebuilds.
- `.nojekyll`, so GitHub does not try to run the site through Jekyll.
- `404.html`, a designed not found page rather than GitHub's default.
- `robots.txt` and `sitemap.xml`.
- Canonical URL, Open Graph and Twitter card tags, all pointing at
  `https://tasalee.online`.
- A `ProfessionalService` structured data block, so Google can read the
  business, the service area and the phone number.
- `img/share.jpg`, the 1200 by 630 preview card.
- A favicon and an apple touch icon built from the mark.

## Two things to change before you tell anyone

1. **The email address.** The page still shows a Gmail address. Hostinger gives
   you email on the domain with most plans. `hello@tasalee.online` converts
   better than Gmail on a page about trust. Search `shubham.malik1684@gmail.com`
   in `index.html`.
2. **The testimonials.** They carry real first names. If those are not people
   who agreed to be quoted, replace them. On a site whose whole argument is
   that it does not repeat what it cannot verify, invented testimonials are the
   one mistake with no way back.

---

## The console, and why it is not going on this domain the same way

You asked for both sites on subdomains. The client site is straightforward. The
console is not, and I want to be plain about why rather than quietly do it.

`console.html` carries your source list, your method, your coverage figures,
and an honest register that says the cadastral geometry is provisional and the
HSVP layout digitisation is not built. On a free GitHub account, Pages only
serves **public** repositories. Putting the console there does not mean
"internal", it means published, indexed and readable by anyone who guesses the
subdomain. A competitor reads your method in ten minutes. A client who wanders
in reads the word "provisional" next to the thing they just paid for.

The `noindex` tag in it keeps it out of search results. It does not keep it
private.

Three ways to have it, in the order I would pick them.

**Keep it local.** It is one HTML file that works perfectly offline, on sample
data, with no server. Open it from your Desktop. Point its backend field at
wherever the API runs. Nothing to set up, nothing to leak, no cost. For a team
of one to three people this is the correct answer and you can stop here.

**Cloudflare Pages with Cloudflare Access.** This genuinely gets you
`console.tasalee.online` behind a login, free, for up to 50 users, with email
one time codes and no passwords to manage. The cost is that you move the
domain's nameservers from Hostinger to Cloudflare, which also makes the public
site faster in India, since Cloudflare has edge locations in Delhi, Mumbai and
Chennai and GitHub does not. If you want this, say so and I will write the
migration out step by step. It is about twenty minutes of work and it is
reversible.

**A private repository, no Pages at all.** Push the console to a private repo
and clone it wherever it is needed. Version history, no public URL. Slightly
more friction than a bookmark, much less than it sounds.

What I would not do is put it on `console.tasalee.online` via GitHub Pages and
call it internal, because it would not be.

---

## When you change the site later

Edit `index.html`, commit, push. GitHub rebuilds in about a minute. There is no
build step and nothing to run.

If you are changing more than a few words, edit the source pieces instead,
`site_body.html` and the rest, run `python3 make_deploy.py`, and copy the
result over `repo/index.html`. The README in the repository says the same thing
in shorter form.

## Sources

- [Managing a custom domain for your GitHub Pages site](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)
- [How to manage DNS records at Hostinger](https://www.hostinger.com/support/1583249-how-to-manage-dns-records-at-hostinger/)
- [Hostinger DNS zone editor guide](https://www.hostinger.com/my/tutorials/how-to-use-hostinger-dns-zone-editor)
