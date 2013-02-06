## What is this?

This is a site that takes C/C++ code and runs it through the gcc preprocessor.

## Why?

A while ago I was working on a tricky nested C macro and had a lot of trouble visualizing the result. After googling around I found out gcc can run a file through the preprocessor with *gcc -E filename.c*. I threw together a C# app in a few minutes and thought would make a neat site so I rewrote it in python.

## How does it work?

The site uses [bottle](http://bottlepy.org) to run the web site. When text is passed to it, it runs it through gcc and returns the parsed output.
