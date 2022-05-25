# Day 75: Project 22, Part One

## Notes

Today we are going to start with a new project again. We are going to learn about micro-location, the ability to detect very small distance between things using the Apple's iBeacon technology.


First is we make use of Core Location framework to request users to allow usage of your current location.

After the user allows you to use the current location, we are going to start scanning beacons with the help of `CLBeaconRegion` and start monitoring for it.

```swift
let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")

locationManager?.startMonitoring(for: beaconRegion)
locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
```


And to update our UI, we are going to use the CLLocationManager Delegate method for beacons.

```swift
func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if let beacon = beacons.first {
        update(distance: beacon.proximity)
    } else {
        update(distance: .unknown)
    }
}
```


## Screenshots
![App-Screenshot](documentation/1.gif)

