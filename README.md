# Welcome to the Read Processing Repository

>[To view this as a public page click here.](https://github.com/Rich-Molecular-Health-Lab/read_processing)
>[To return to the repository and directories click here.](https://github.com/Rich-Molecular-Health-Lab/read_processing)

## MinION Data

The ONT sequencers basically measure electrical signals as strands of DNA pass through each nanopore. The MinKNOW software uses an algorithm to convert each signal to its estimated sequence of A's/G's/C's/T's in real time, but those on-the-fly basecalls are quite messy. It is standard practice to take the original signal data after the run has completed and use a slower, more precise algorithm to re-basecall the data with greater precision.  

## Syntax of the Bash Scripts in this Repository

If you see a step involving the code "sbatch", that means I am referencing a separate file with the extension .sh as a complete batch script that runs from the HCC's SLURM server. You should transfer your version of that script to the local working directory before running the sbatch code. Sometimes I also run shorter jobs as an [interactive job](https://hcc.unl.edu/docs/submitting_jobs/creating_an_interactive_job/). You can read more about that on the HCC manual if you want to try it.  

I also use a custom language engine in these scripts that I named "terminal." If you see a chunk of code with {terminal, warning = FALSE} written where you would usually see {r} at the top of the chunk, then running the chunk should only print that code as a text string in this document. This just makes it easier for me to copy and paste the code directly into the terminal panel that I use in my R Studio window when running code through a remote server instead of my local R console. There are ways to set R Studio up to run code through multiple servers, but I find this the simplest way to switch back and forth while still keeping a record of the code that have used or changes I have made to it.  

## Config Paths and Parameters

I keep track of my parameters for workflows and paths to different directories or files using the config package and file. You will find my configuration file in the base directory of whichever repository I have written it for. It is always listed as `config.yml`. If you are struggling to find the path to a file that I reference in any script, every path listed in that config file directs you to its location relative to the base of this repository. Read more about how config works [here](https://rstudio.github.io/config/).

## Intro to High Performance Computing (HPC)

The basecalling step is the most memory-intensive stage of our bioinformatic pipelines. Most local hard drives cannot handle the task, especially for the maximum-precision algorithm we use.  High-Performance Computing (HPC) systems and remote clusters (like the Holland Computing Center's (HCC) remote server known as *Swan*) are powerful computers designed to handle big tasks that are too demanding for personal computers. These systems allow us to connect remotely and use their resources to process large amounts of data quickly and efficiently. For steps like ONT basecalling, which require a lot of memory and processing power, HPC systems are essential to get the job done without overwhelming our own computers.  

## Getting Started with the Holland Computing Center (HCC)

Any UNO/UNMC/UNL student affiliated with an established HCC research group can sign up for a free account to access the system. [Follow the instructions here](https://hcc.unl.edu/docs/accounts/) and enter "richlab" as your group. I will receive an email to approve your membership, and then your account will become active. You should look through the rest of the HCC's manual to learn some of the basics before you begin using it. Begin by working through the following:  

1. [Connecting to the Clusters](https://hcc.unl.edu/docs/connecting/)
  - My preferred method for step 2 (*Open a terminal or SSH client*) is to use the terminal window inside R Studio. That makes it easier to move smoothly between code languages and servers within a single R Markdown script like this one.
2. [Handling Data](https://hcc.unl.edu/docs/handling_data/)
  - The most important storage guidelines are those explaining when/how to use your home vs. work directories and the overall limits that we share as a group across every member's accounts.
  - Data transfer can initially trip people up, and you have several options. I used to use cyber duck for uploading/downloading files, but more recently I switched to Globus Connect.
3.  [Submitting Jobs](https://hcc.unl.edu/docs/submitting_jobs/)
  - This workflow references modularized bash scripts that you can upload to your working directory and submit according to the instructions on the HCC site. You do not need to worry as much about understanding how to find/select/use different apps/modules on the server (I have taken care of that for our pipelines), but you do need to know how to take the scripts I have written, edit a few of the parameters, and tell the HCC when/how to run it for you.

# Set up your Directories

## Load Reads to HCC Directory for Processing

You can use any number of FTPs (*File transfer protocols*) to move directories and files from a local hard drive to your working directory on the HCC. I use [Globus Connect Personal](https://www.globus.org/globus-connect-personal). Follow the installation and use instructions to transfer your local copy of this entire repository to a location within your personal `work` directory on the HCC. Then you can simply use the sync option each time you begin working to ensure all your relative paths and directories are available in both locations.  
  
If you set your working directory on swan to the same as the working directory for this R project, then all the paths used here will also work in any scripts you run there.

# First Time Steps: Setting Up your Working Swan Environment

The first time you process any reads on the HCC, you should work through the script linked below. You may download the R markdown file to work from, or open the html version in a browser for a more readable tutorial. You only need to work through this script once. After that you should be able to start directly from one of the Read Processing scripts.

- [RemoteHCC_FirstUse.Rmd](RemoteHCC_FirstUse.Rmd)
  - To view from your browser: [RemoteHCC_FirstUse.html](https://github.com/Rich-Molecular-Health-Lab/read_processing/RemoteHCC_FirstUse.html)