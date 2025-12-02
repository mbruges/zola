---
title: Hosting on Cloudflare's R2
description: Database delivery demystified
date: 2025-12-01
draft: true
extra:
  icon: ☁️
---

I've been building an internal knowledge base at work recently, and wanted a quick-and-dirty means of hosting so that everyone across the organisation could access.

Normally, I'd simply whack it on a public Github repo and use Cloudflare Pages to build and host from there. However, some parts of the site are _moderately_ sensitive - or at least information that I'd rather not have slurped up by crawlers _et al_. 

The perfect opportunity, then, to test out something I'd seen mentioned on a HN post a while ago: hosting the site directly from an R2 bucket.

## Domains and databases 

Setting up the bucket is straightforward:

1. In the Cloudflare admin panel, go to `Storage & Databases -> R2 Object Storage`. 
1. Here, create a new bucket - with a name that's easy to identify with the site you're hosting.
1. Upload single file - try _"hello world!"_ in `test.html` - for testing later.
1. Navigate to the `Settings` tab and add a `Custom Domain`. This should (obviously) be one that you hold with Cloudflare, and the DNS record update should be handled automatically.

The bucket is now serving to anyone visiting your `site.example.com` domain. Try it out by visiting `https://site.example.com/test.html` - you should see your "hello world!" from step 3.

## Adding content

In my case, I had a folder of static HTML pages built on my local machine. The easiest way to dump these into the bucket is to click-and-drag into the upload pane on the Cloudflare panel. This is fine for a one-off, but will get tedious with regular updates.

`Rclone` is the best tool I've found for syncing content to a bucket. 

1. Download and install `rclone` if it isn't already on your system.
1. Back on the main `R2 Object Storage` page of the Cloudflare Admin Panel, click the <kbd>{} Manage</kbd> button  under the **Account Details** heading.
1. `Create User API token`, with `Object read & write` permissions. For added security, limit it to specifically the bucket for your site.
1. Save down the credentials somewhere, ready to enter into `rclone`.
1. In your terminal, type `rclone config`, and follow the instructions to link your R2 instance with `rclone` - name it `r2` for convenience.
1. Test out the connection by running `rclone ls r2:name-of-bucket/`.
1. If it's been configured correctly, you should see your test file `test.html` from earlier listed.
1. Now, to sync your assets to the bucket, run `rclone sync ./assets/* r2:name-of-bucket/`.
1. Run `rclone ls r2:name-of-bucket/` again to check everything's uploaded successfully.

## Fixing `index.html`

We can now navigate to `site.example.com` and see our page in all its glory...

```
ERROR 404
Object not found

This object does not exist or is not publicly accessible at this URL. Check the URL of the object that you're looking for or contact the owner to enable Public access.
```

Ah. A reminder that R2 is not really _designed_ to host whole sites: whereas most servers will default to `index.html` if a client requests the root of a directory, R2 simply follows our request to the letter, attempting to serve the page `/`, which obviously doesn't exist.

Fortunately, there's a quick fix for this, using **Transform Rules**. We're going to create two rules: one to fix the site root, and another for the habit that some static site generators have of defaulting their links to `/section/subsection/`, without an explicit `.html` page. 

1. From the main Cloudflare Admin panel, select the domain you're serving from (e.g. `example.com`)
1. In the sidebar, select `Rules -> Overview`, then click the `Create rule` button
1. Rule one:
    1. Name the first rule something like `Index.html for site root`
    1. Select **Custom filter expression**
    1. In the **When incoming requests match…** section, set:
| Field | Operator | Value |
| :---: | :---: | :---: |
| URI Path | Ends with | / |
    1. Under **Then...**, select **Rewrite to..** and **Dynamic** from the dropdown.
    1. Enter `concat(http.request.uri.path, "/index.html")` as the expression, and hit `Save`
1. Rule two:
    1. Name this second rule something like `Index.html for subdirectories`
    1. Select **Custom filter expression**
    1. In the **When incoming requests match…** section, set:
      | Field | Operator | Value |
      | :---: | :---: | :---: |
      | URI Path | Does not contain | . |
    1. Click 'And' to add another condition:
      | Field | Operator | Value |
      | :---: | :---: | :---: |
      | URI Path | Does not end with | / |
    1. Under **Then...**, select **Rewrite to..** and **Dynamic** from the dropdown.
    1. Enter `concat(http.request.uri.path, "index.html")` as the expression, and hit `Save`
1. You can limit these rules to just your specific site (rather than all that are hosted on your domain), you can add an 'And' rule of:
  | Field | Operator | Value |
  | :---: | :---: | :---: |
  | Hostname | Equals | `site.example.com` |
  
Note that the second rule has a _very slight_ difference in the rewrite: we omit the leading `/` from `index.html`.

## Wrapping up and costing

Give all those settings a minute or two to propogate across the network, then try again visiting your site. It _should_ now present you with your `index.html` page, just like a real server.

It is worth mentioning that this sort of hosting isn't _totally_ free. Generally, you can serve up to 10 million requests per month before Cloudflare will start charging you - you can play with [their calculator here](https://r2-calculator.cloudflare.com/). Frankly, if you're hitting those numbers, you can probably afford to set things up properly. 

Similarly, the sales team will come knocking on your door if you start hosting very large files, but for a simple static site with nothing more complex that some `HTML` and images, you're good to go.
