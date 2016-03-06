# Precipitate

## Description

Precipitate is a weather app that presents the forecast data in a series of charts to make viewing a whole day's weather quick and intuitive. The application will save the latest forecast on your device for up to one hour, so a recently-acquired forecast can be reviewed again without an internet connection, such as when underground. 

Weather data is visible in three sets of charts: 12-hour, 48-hour, and 7-day.

The 12-hour and 48-hour data points are:

* Actual Temperature
* Apparent Temperature
* Precipitation Probably
* Rainfall (including liquid volume of snow)
* Snowfall
* Wind Speed
* Cloud Cover
* Visibility
* Ozone
* Humidity
* Dew Point
* Pressure

The 7-day data points are:

* Min Actual Temperature
* Max Actual Temperature
* Min Apparent Temperature
* Max Apparent Temperature
* Precipitation Probability
* Rainfall (including liquid volume of snow)
* Max Precipitation Intensity
* Wind Speed
* Cloud Cover
* Visibility
* Ozone
* Humidity
* Dew Point
* Pressure

#### Precipitate is powered by the [Forecast.io API](http://forecast.io/). 

There are four options for units of measure defined by the Forecast API:

| Units | Temp | Snowfall | Rainfall | Distance | Windspeed | Pressure |
|:--:|:-:|:--:|:-----:|:--:|:---:|:----:|
| US | ℉ | in | in/hr | mi | mph | mbar |
| SI | ℃ | ㎝ | ㎜/hr | ㏎ | m/s | hPa |
| UK | ℃ | ㎝ | ㎜/hr | mi | mph | hPa |
| CA | ℃ | ㎝ | ㎜/hr | ㏎ | kph | hPa |

And 27 language options provided by the API, **which will only affect the summary label at the top of the screen**:

* Arabic (ar)
* Bosnian (bs)
* Chinese, Simplified (zh)
* Chinese, Traditional (zh-tw)
* Cornish (kw)
* Czech (cs)
* Dutch (nl)
* English (en)
* German (de)
* Greek (el)
* French (fr)
* Croatian (hr)
* Hungarian (hu)
* Icelandic (is)
* Igpay Atinlay (pig latin)
* Italian (it)
* Norwegian Bokmål (nb)
* Polish (pl)
* Portuguese (pt)
* Russian (ru)
* Spanish (es)
* Serbian (sr)
* Slovak (sk)
* Swedish (v)
* Tetum (tet)
* Turkish (tr)
* Ukrainian (uk)

***Labels and messages from the app itself are only provided in English (en) at this time.***

Precipitate provides weather information for the device's current location. Please authorize location services when prompted.

## Dependencies

CocoaPods used in distributed code:

* Alamofire
* Charts (by Daniel Cohen Gindi and Philipp Jahoda)
* FontAwesome.swift
* INTULocationManager
* MarqueeLabel-Swift
* SnapKit
* SwiftHEXColors
* SwiftyDate
* SwiftyJSON
* SwiftySettings
* SwiftyUserDefaults

CocoaPods used during testing:

* Quick
* Nimble
* Nimble-Snapshots
* FBSnapshotTestCase
* KIF

## Attributions

##### Iconography
* [Weather icons](https://erikflowers.github.io/weather-icons/) by [Erik Flowers](https://twitter.com/erik_flowers), [SIL OFL 1.1](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)
* Settings "gear" icon from [Font Awesome](https://fortawesome.github.io/Font-Awesome/) by [Dave Gandy](https://twitter.com/davegandy), [SIL OFL 1.1](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

Special thanks to [Joe Burgess](https://twitter.com/jmburges) & [Tim Clem](https://github.com/misterfifths) at [The Flatiron School](http://flatironschool.com/ios) for all your help and advice.

## Author

Mark Edward Murray, [markedwardmurray+precipitate@gmail.com](mailto:markedwardmurray+precipitate@gmail.com)

## License

Precipitate is available under the MIT license. See the LICENSE.md file for details.
