
# ARPointCloud

This project is a basic example of visualizing a `pointCloud` in `ARKit` using the `rawFeaturePoints` available from the `ARSession` current frame.

All the code is fully commented so the apps functionality should be clear to everyone.

**Requirements:**

This project was written in Swift 4, and at the time of writing uses Xcode 9.4 Beta.
The project is setup for iPhone, and in Portait Orientation.

**Core Functionality:**

This project visualizes the `rawFeaturePoints` from the `ARSession`, and displays these as `SCNNodes`, alongside a `UILabel` which displays the number of `rawFeaturePoints` which have been detected. 

**Notes:**

Please note, that the use of this is not recommended for any distrubuted application.

The performance isn't great (although some gains were made) using the `clone` function of `SCNNode`.

As `Apple` also stipulates: *`ARKit` does not guarantee that the number and arrangement of raw feature points will remain stable between software releases, or even between subsequent frames in the same session. Regardless, the point cloud can sometimes prove useful when debugging your app's placement of virtual objects into the real-world scene.*
