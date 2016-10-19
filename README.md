#Extra functions for [lidR](https://github.com/Jean-Romain/lidR) package

This package contains tools which are hard to make cross-platform in a standalone R package. In other word it's kind of hard to make them running on GNU/Linux and therefore it is even harder to make them running on Windows.

The following functions works fine on GNU/Linux if you follow the instructions. For Windows, the principles are the same. If a skilled computer scientist is able to make it working on Windows please propose a pull request. Personnaly I will not try to make it working on Windows.

If I figure out a way to make more convient tools I will move these tools to the main package `lidR`.

## Ground classification

`ground_classify` enable to classify a points as ground and non-ground. This feature is based on the PCL library. You therefore need to compile and install PCL: [follow this link](http://pointclouds.org/downloads/) before to compile `lidRExtra`

The compilation directive given in the `makevar` file are the one requiered on Linux Mint. It might be the same at least for every Linux distros derived from Debian. But if the path to the shared librairies differ from mine the `makevar` file will not be correct anymore. If you encounter difficulties during the compilation send me an email, I will help you.
