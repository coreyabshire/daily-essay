daily-essay
===========

Emacs module to ease creation of a daily essay.

Provides convenience functions related to creating a daily
essay. The primary one being at this point a function that does the
following.

 1) Ensure that a directory exists in some base path, wherein the
 name of the directory is date stamped with today's date.

 2) Ensure a copy of some template file exists in that directory.

 3) Opens that file as a buffer for editing, and that the point is
 positioned at the appropriate location to begin editing.

You may wish to require this module as part of your .emacs file and
map some global key to it. I have mine mapped to (kbd "M-g d").

I created this file as a convenience after a few days of getting
into a habit of writing an essay every day. I was looking to
increase my proficiency in both writing and in TeX and so decided
forcing myself to practice daily was the best way to do that. But
that didn't mean I had to endure all the overhead of creating the
directory and such every day to do so.
