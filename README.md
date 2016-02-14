# Precipitate

## Description

Precipitate is a weather app that presents the forecast data in a series of charts to make viewing a whole day's weather quick and intuitive. The application will save the latest forecast on your device for up to one hour, so a recently-acquired forecast can be reviewed again without an internet connection, such as when underground. 

Precipitate is powered by the Forecast.io API which provides data in two timescales, 48-hour and 7-day.

The 48-hour data points are:

* Temperature
* Apparent Temperature
* Precipitation Probably
* Precipitation Intensity (Rainfall)
* Precipitation Accumulation (Snowfall)
* Wind Speed
* Cloud Cover
* Visibility
* Ozone
* Humidity
* Dew Point
* Pressure

The 7-day data points are:

* Min Temperature
* Max Temperature
* Min Apparent Temperature
* Max Apparent Temperature
* Precipitation Probability
* Precipitation Intensity
* Max Precipitation Intensity
* Wind Speed
* Cloud Cover
* Visibility
* Ozone
* Humidity
* Dew Point
* Pressure

There are four options for units of measure defined by the Forecast API:

| Option | Temp | Snowfall | Rainfall | Distance | Windspeed | Pressure |
|:--:|:-:|:--:|:-----:|:--:|:---:|:----:|
| US | ℉ | in | in/hr | mi | mph | mbar |
| SI | ℃ | ㎝ | ㎜/hr | ㏎ | m/s | hPa |
| UK | ℃ | ㎝ | ㎜/hr | mi | mph | hPa |
| CA | ℃ | ㎝ | ㎜/hr | ㏎ | kph | hPa |

## Dependencies

CocoaPods used in distributed code:

* Charts (by Daniel Cohen Gindi and Philipp Jahoda)
* Alamofire
* INTULocationManager
* SnapKit
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

Special thanks to Joe Burgess & Tim Clem at The Flatiron School.

## Author

Mark Edward Murray, [markedwardmurray+precipitate@gmail.com](mailto:markedwardmurray+precipitate@gmail.com)

## License

Precipitate is available under the MIT license. See the LICENSE.md file for details.
