# Precipitate

## Description

Precipitate is a weather app that presents the forecast data in a series of charts to make viewing a whole day's weather quick and intuitive. The application will save the latest forecast on your device for up to one hour, so a recently-acquired forecast can be reviewed again without an internet connection, such as when underground. 

Precipitate is powered by the Forecast.io API which provides data in two timescales, 48-hour and 7-day.

The 48-hour data points are:

* Temperature (ºF)
* Apparent Temperature (ºF)
* Precipitation Probably (0-1.0)
* Precipitation Intensity 
* Precipitation Accumulation (inches)
* Wind Speed (mph)
* Cloud Cover (0-1.0)
* Visibility (0-10 miles)
* Ozone (Dobson units)
* Humidity (0-1.0)
* Dew Point (ºF)
* Pressure (millibars)

The 7-day data points are:

* Min Temperature (ºF)
* Max Temperature (ºF)
* Min Apparent Temperature (ºF)
* Max Apparent Temperature (ºF)
* Precipitation Probability (0-1.0)
* Precipitation Intensity
* Max Precipitation Intensity
* Wind Speed (mph)
* Cloud Cover (0-1.0)
* Visibility (0-1.0)
* Ozone (Dobson units)
* Humidity (0-1.0)
* Dew Point (ºF)
* Pressure (millibars)

## Dependencies

CocoaPods used in distributed code:

* Charts (by Daniel Cohen Gindi and Philipp Jahoda)
* Alamofire
* INTULocationManager
* SwiftyJSON

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
