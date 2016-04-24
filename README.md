Lifted Nonlinear Cuts Animation
=====

### What is this?
This [technical report](http://arxiv.org/abs/1512.04644) proposed two valid inequalities for the AC power flow equations in a 4-Dimensional space (w_i, w_j, w^r, w^i).
This R script produces a 2D animation of these inequalities in the w_i, w^r space.
The w_j variable is captured overtime and the w^i space is projected onto the 2D space.
The "receding" lines indicate parts of the w^i space that and are projected onto the w_i, w^r space.

'make.it' is a script that builds an animated gif of the inequalities.  An example can be viewed [here](https://imgur.com/gallery/7JjPfy6).

By chaining the variable bound values at the beginning of 'make.r' you can explore how the cuts change based on the input parameters.  The default parameters are set near the extreme limits of [typical power system design practices](https://books.google.com/books/about/Power_System_Stability_and_Control.html?id=2cbvyf8Ly4AC).

### Requirements
This script requires R for building the PDFs and imagemagick's convert for combining them into a gif.  The bash terminal is required for 'make.it'

