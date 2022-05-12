# Day 60: Project 16, Part One

## Notes

Today we start again with a project and we will dive to Apple MapKit Framework.


## MKMapView
`MKMapView` is a map interface, similar to the one that the Maps app provides. You use this class as-is to display map information and to manipulate the map contents from your application

You need to add `import MapKit` whenever you use this class to your app

## MKAnnotation
`MKAnnotation` is a protocol. An object that adopts this protocol manages the data that you want to display on the map surface. It does not provide the visual representation displayed by the map. Instead, your map view's delegate provides the MKAnnotationView objects needed to display the content of your annotations. 

## CLLocationCoordinate2D
`CLLocationCoordinate2D` is a struct. It is the latitude and longitude associated with location.



## Screenshots
![App-Screenshot](documentation/1.gif)

