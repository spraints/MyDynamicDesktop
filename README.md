# Make me a dynamic desktop image

**Goal:** Given a series of pictures taken from a stationary location, create a dynamic desktop HEIC file for macOS. Given the location and time and date of the photos, set the correct metadata for solar angle and azimuth, or at least set the correct time.

## Resources

* https://gist.github.com/leptos-null/c88e8c3c0f9f6860c7500826031c8551 - Mojave Dynamic Desktop - How it works. Has two code samples: calculating geo information, and extracting the solar metadata from HEIC files.
* https://github.com/Pyongpyong/DynamicDesktopFromMojaveHeic - Mac app to generate a dynamic desktop file. I haven't gotten this to read a file and haven't figured out how to create one with this.
* https://gist.github.com/bradfitz/eb904c181417d978926da5e33b9c5f11 - dump of the parts of an HEIC/HEIF of one of the default dynamic backgounds.
* https://github.com/jdeng/goheif - GoHeif - A go gettable decoder/converter for HEIC based on libde265.
