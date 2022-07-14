# MIDS1D
## Repository for MIDS1D Course Challenge

### Challenge Questions
- **Exchange one of the images in the sample index.html and see if you can display that in the browser. Did you need to restart the server to do that? Why or why not?**
	- I am able to display the new image after saving the index.html file and refreshing the browser. This is needed because the initial command `./darkhttpd html --port 12345` references the current state of the index.html file. When the file is updated, the command must run again (via browser refresh) and pulls the newly changed index.html file, which has the modified image.
- **How can you look up the process ID of your server? Document the command line used and the output**

### Commands used
**Install make**
`sudo apt install make`

**Install darkhttpd**
`git close https://github.com/emikulic/darkhttpd`

**Install recode**
`sudo apt install recode`

**Install tar**
`sudo apt install tar`

**Copy tarball and add to local directory**
`cp website.tar.gz ~/projects/MIDS1D`

**Unpack tarball**
`tar xvf website.tar.gz`

**I was having issues running make command, receiving 127 error, so I ran the following to install GNU C compiler and was able to proceed**
`sudo apt install gcc`

**Create directory inside of /website/darkhttpd called 'html' and cd into directory**
`mkdir html`

**Copy index.html to new directory**
`cp index.html html`

**make index.html executable**
`chmod +x index.html`

**copy images directory from where unpacked tarball to newly created html directory**
`cp -R images ~/projects/MIDS1D/website/darkhttpd/html`
