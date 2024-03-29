# MIDS1D
## Repository for MIDS1D Course Challenge

### Instructions
1. Clone the repository
2. Navigate to the /website/html directory
3. Execute script `./generate_site.sh`, which will create index.html file used for site
4. Navigate to /website directory
5. Execute `./darkhttpd html --port 12345`
6. Open in web browser

### Challenge Questions
- **Exchange one of the images in the sample index.html and see if you can display that in the browser. Did you need to restart the server to do that? Why or why not?**
	- I am able to display the new image after saving the index.html file and refreshing the browser. This is needed because the initial command `./darkhttpd html --port 12345` references the current state of the index.html file. When the file is updated, the command must run again (via browser refresh) and pulls the newly changed index.html file, which has the modified image.
- **How can you look up the process ID of your server? Document the command line used and the output**
	- `pgrep darkhttpd` returned PID 80797 (note: when stopping darkhttpd and then restarting using #5 above in the instructions, new PID obtained using the same command)

### Commands used (NOTE: if variation of command below used, I did not document it here (e.g. `chmod +x generate_site.sh`)
**Install make**
`sudo apt install make`

**Install darkhttpd**
`git clone https://github.com/emikulic/darkhttpd`

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

**Create directory inside of /website/darkhttpd called 'html'**
`mkdir html`

**Copy index.html to new directory**
`cp index.html html`

**make index.html executable**
`chmod +x index.html`

**copy images directory from where unpacked tarball to newly created html directory**
`cp -R images ~/projects/MIDS1D/website/darkhttpd/html`

**Before going too far down potentially incorrect path, I needed to copy and move all darkhttpd files because they were in a submodule within my MIDS1D repo due to cloning the project from github within the repo and initializing it to test. I ran `cp {filename} ~/projects/MIDS1D/website` for every file and `cp -R {directoryname} ~/projects/MIDS1D/website` for every subdirectory. This removed the need for the submodule and allowed me to keep everything in the same repository**

**Moving working files to ../html/archives directory to clean up html directory and for potential future reference (executed while in ../html directory)**
`mv {filename} archives`

**Reformatted 6 images that were not displaying. I did this manually using `mv`, but found the names of the images that were not displaying by using the browser and seeing which were returning 404s. I used the `iconv -t ASCII//TRANSLIT <<< {filename}` command for each of the 6 files and then manually renamed each one**
*Note: I tried to write variations of the for loop below but was unsuccessful in using the command above to rename the files*
```
for file in *
do
	mv $file (iconv -t ASCII/TRANSLIT <<< {filename})
done
```
**After all of the above, I still see one image not displaying and do not know why: 'Portal Math Banner Background ka.jpg'**
