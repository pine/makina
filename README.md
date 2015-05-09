Makina
------

[![Build status](https://ci.appveyor.com/api/projects/status/mp4041wuhjwjakbp/branch/master?svg=true)](https://ci.appveyor.com/project/pine613/makina/branch/master)
[![Dependency Status](https://gemnasium.com/pine613/makina.svg)](https://gemnasium.com/pine613/makina)

Makina is unofficial Skype API for Windows. It implements by UI Automation that uses image recognition (OpenCV) and optical character recognition (Tesseract OCR).


## Development environments

  - JRuby
  - AutoHotKey


## System requirements

  - Windows 8.1
  - Skype 7.3
  - Java 1.8
  - JRuby 1.7


### Sample CLI command

```
$ jgem install bundler
$ bundle install --path vendor/bundle
$ .\bin\send-chat-message.bat
Username: username
Message: message
Starting ...
OK
Opening chat for username ...
[log] CLICK on L(986,315)@S(0)[0,0 1920x1200]
OK
[log] CLICK on L(1018,1076)@S(0)[0,0 1920x1200]
[log] CLICK on L(1018,1076)@S(0)[0,0 1920x1200]
[log]  TYPE "#ENTER."
```

## Test

```
$ bundle install --path vendor/bundle
$ bundle exec rake spec
```

## License
GNU General Public License v3<br />
Copyright (c) 2015 Pine Mizune
