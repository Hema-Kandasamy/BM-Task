# BM-Task
This is the task for BM

# Application

This is an mobile client application to show the response from server
This app is an example on how to use MVVM in an iOS application written in Swift. Using Bindings and Generics.
It uses a simple restful service to get informationfrom server.

Run "pod install" in folder where Podfile is located and the open project in xcode using the Task.xcworkspace.

## Network Layer

Network layer is divided to make request and handle the same. Easy to implement Mocked stub for tests.

## Core Data
Included core data model and it's method to fetch/ save/ delete.
Since this is two page application and getting data from server on the first time can be used and passed across. 
So, you can use core data values when in offline.

## Custom Radio button
Included custom radio button class. It is independent of the project. This files just can be added and create a new framework from Xcode easily.


## RXSwift
We can also do MVVM with RxSwift, Yet to be implmented        


