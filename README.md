autotuneATC
===========

This was my NPR Serendipity Days project for January 2014. It was designed to apply the All Things Considered theme song, using an autotune-style effect, to arbitrary input sound files. However, I ran in to a number of obstacles along the way that prevented this dream from coming to fruition, so instead of applying autotune, it simply modulates the pitch of the input audio at a frequency that roughly corresponds to the various notes in the ATC theme song.

Usage
-----------

Don't.

But if you really insist...make sure you have [SoX](http://sox.sourceforge.net/) installed, clone this repo, and run as follows:

`$ ./autotuner.rb input_filename output_filename [duration_ratio]`


