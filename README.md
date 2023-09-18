# Wayback Machine Downloader

[![Gem Version](https://badge.fury.io/rb/wayback_machine_downloader.svg)](https://rubygems.org/gems/wayback_machine_downloader/)
[![Build Status](https://travis-ci.org/hartator/wayback-machine-downloader.svg?branch=master)](https://travis-ci.org/hartator/wayback-machine-downloader)

Download an entire website from the Internet Archive Wayback Machine.

## Installation

You need to install Ruby on your system (>= 1.9.2) - if you don't already have it.
Then run:

    gem install wayback_machine_downloader

**Tip:** If you run into permission errors, you might have to add `sudo` in front of this command.

## Basic Usage

Run wayback_machine_downloader with the base url of the website you want to retrieve as a parameter (e.g., http://example.com):

    wayback_machine_downloader http://example.com

## How it works

It will download the last version of every file present on Wayback Machine to `./websites/example.com/`. It will also re-create a directory structure and auto-create `index.html` pages to work seamlessly with Apache and Nginx. All files downloaded are the original ones and not Wayback Machine rewritten versions. This way, URLs and links structure are the same as before.

## Advanced Usage

	Usage: wayback_machine_downloader http://example.com

	Download an entire website from the Wayback Machine.

	Optional options:
	    -d, --directory PATH             Directory to save the downloaded files into
					     Default is ./websites/ plus the domain name
	    -s, --all-timestamps             Download all snapshots/timestamps for a given website
	    -f, --from TIMESTAMP             Only files on or after timestamp supplied (ie. 20060716231334)
	    -t, --to TIMESTAMP               Only files on or before timestamp supplied (ie. 20100916231334)
	    -e, --exact-url                  Download only the url provided and not the full site
	    -o, --only ONLY_FILTER           Restrict downloading to urls that match this filter
					     (use // notation for the filter to be treated as a regex)
	    -x, --exclude EXCLUDE_FILTER     Skip downloading of urls that match this filter
					     (use // notation for the filter to be treated as a regex)
	    -a, --all                        Expand downloading to error files (40x and 50x) and redirections (30x)
	    -c, --concurrency NUMBER         Number of multiple files to download at a time
					     Default is one file at a time (ie. 20)
	    -p, --maximum-snapshot NUMBER    Maximum snapshot pages to consider (Default is 100)
					     Count an average of 150,000 snapshots per page
	    -l, --list                       Only list file urls in a JSON format with the archived timestamps, won't download anything
	    -u, --user-agent STRING          UserAgent for connection (Default is Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0)
	    
## Specify directory to save files to

    -d, --directory PATH

Optional. By default, Wayback Machine Downloader will download files to `./websites/` followed by the domain name of the website. You may want to save files in a specific directory using this option.

Example:

    wayback_machine_downloader http://example.com --directory downloaded-backup/
    
## All Timestamps

    -s, --all-timestamps 

Optional. This option will download all timestamps/snapshots for a given website. It will uses the timestamp of each snapshot as directory.

Example:

    wayback_machine_downloader http://example.com --all-timestamps 
    
    Will download:
    	websites/example.com/20060715085250/index.html
    	websites/example.com/20051120005053/index.html
    	websites/example.com/20060111095815/img/logo.png
    	...

## From Timestamp

    -f, --from TIMESTAMP

Optional. You may want to supply a from timestamp to lock your backup to a specific version of the website. Timestamps can be found inside the urls of the regular Wayback Machine website (e.g., https://web.archive.org/web/20060716231334/http://example.com). You can also use years (2006), years + month (200607), etc. It can be used in combination of To Timestamp.
Wayback Machine Downloader will then fetch only file versions on or after the timestamp specified.

Example:

    wayback_machine_downloader http://example.com --from 20060716231334

## To Timestamp

    -t, --to TIMESTAMP

Optional. You may want to supply a to timestamp to lock your backup to a specific version of the website. Timestamps can be found inside the urls of the regular Wayback Machine website (e.g., https://web.archive.org/web/20100916231334/http://example.com). You can also use years (2010), years + month (201009), etc. It can be used in combination of From Timestamp.
Wayback Machine Downloader will then fetch only file versions on or before the timestamp specified.

Example:

    wayback_machine_downloader http://example.com --to 20100916231334
    
## Exact Url

	-e, --exact-url 

Optional. If you want to retrieve only the file matching exactly the url provided, you can use this flag. It will avoid downloading anything else.

For example, if you only want to download only the html homepage file of example.com:

    wayback_machine_downloader http://example.com --exact-url 


## Only URL Filter

     -o, --only ONLY_FILTER

Optional. You may want to retrieve files which are of a certain type (e.g., .pdf, .jpg, .wrd...) or are in a specific directory. To do so, you can supply the `--only` flag with a string or a regex (using the '/regex/' notation) to limit which files Wayback Machine Downloader will download.

For example, if you only want to download files inside a specific `my_directory`:

    wayback_machine_downloader http://example.com --only my_directory

Or if you want to download every images without anything else:

    wayback_machine_downloader http://example.com --only "/\.(gif|jpg|jpeg)$/i"

## Exclude URL Filter

     -x, --exclude EXCLUDE_FILTER

Optional. You may want to retrieve files which aren't of a certain type (e.g., .pdf, .jpg, .wrd...) or aren't in a specific directory. To do so, you can supply the `--exclude` flag with a string or a regex (using the '/regex/' notation) to limit which files Wayback Machine Downloader will download.

For example, if you want to avoid downloading files inside `my_directory`:

    wayback_machine_downloader http://example.com --exclude my_directory

Or if you want to download everything except images:

    wayback_machine_downloader http://example.com --exclude "/\.(gif|jpg|jpeg)$/i"

## Expand downloading to all file types

     -a, --all

Optional. By default, Wayback Machine Downloader limits itself to files that responded with 200 OK code. If you also need errors files (40x and 50x codes) or redirections files (30x codes), you can use the `--all` or `-a` flag and Wayback Machine Downloader will download them in addition of the 200 OK files. It will also keep empty files that are removed by default.

Example:

    wayback_machine_downloader http://example.com --all

## Only list files without downloading

     -l, --list

It will just display the files to be downloaded with their snapshot timestamps and urls. The output format is JSON. It won't download anything. It's useful for debugging or to connect to another application.

Example:

    wayback_machine_downloader http://example.com --list

## Maximum number of snapshot pages to consider

    -p, --maximum-snapshot NUMBER

Optional. Specify the maximum number of snapshot pages to consider. Count an average of 150,000 snapshots per page. 100 is the default maximum number of snapshot pages and should be sufficient for most websites. Use a bigger number if you want to download a very large website.

Example:

    wayback_machine_downloader http://example.com --maximum-snapshot 300    

## Download multiple files at a time

    -c, --concurrency NUMBER  

Optional. Specify the number of multiple files you want to download at the same time. Allows one to speed up the download of a website significantly. Default is to download one file at a time.

Example:

    wayback_machine_downloader http://example.com --concurrency 20

## Specify UserAgent for connection

     -u, --user-agent STRING

UserAgent for connection (Default is Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0)

Example:

    wayback_machine_downloader http://example.com --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"

## Using the Docker image

As an alternative installation way, we have a Docker image! Retrieve the wayback-machine-downloader Docker image this way:

    docker pull hartator/wayback-machine-downloader

Then, you should be able to use the Docker image to download websites. For example:

    docker run --rm -it -v $PWD/websites:/websites hartator/wayback-machine-downloader http://example.com

## Browse the local copy

Now you have downloaded a local copy of a website from the archive.  If it does not properly load or display in your browser, most likely wrong absolute URLs are part of the problem.  That means, the HTML files reference - for example - a stylesheet at the location it was once hosted (like `https://yourolddomaincontent.com/style.css`).  To have the page served from your local copy, these URLs have to be rewritten to refer to the local content (like `style.css`)

While [a feature request (#26) exists](https://github.com/hartator/wayback-machine-downloader/issues/26), no one implemented it yet.

If you work on a unixoid system, following `sed` command might help you for starters.  The example assumes that the refered domain is `https://yourolddomaincontent.com` and stored in the directory `websites`:

    grep --recursive --files-with-matches 'yourolddomaincontent.com' websites | xargs sed --in-place 's|https\?://yourolddomaincontent.com||g'

Or, with short options:

    grep -rl 'yourolddomaincontent.com' websites | xargs sed -i 's|https\?://yourolddomaincontent.com||g'

However, you might find, that also subdomains like `www.yourolddomaincontent.com` or even URLs with port-information like `www.yourolddomaincontent.com:80` are used.  In that case, adjust the sed call appropriately.

You might still achieve better results when serving the files via a web server than to open them directly with your browser, the list of commands at https://gist.github.com/willurd/5720255 might be a good start to evaluate your options.

## Contributing

Contributions are welcome! Just submit a pull request via GitHub.

To run the tests:

    bundle install
    bundle exec rake test
