# KServices

[![Version](https://img.shields.io/cocoapods/v/KServices.svg?style=flat)](https://cocoapods.org/pods/KServices)
[![License](https://img.shields.io/cocoapods/l/KServices.svg?style=flat)](https://cocoapods.org/pods/KServices)
[![Platform](https://img.shields.io/cocoapods/p/KServices.svg?style=flat)](https://cocoapods.org/pods/KServices)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

KServices is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KServices'
```

# This package for KeyChain save and load data

<br>

## How it use in swift

```swift
     // for save data

            KServices.save(service: "myServices", account: "michelle", data: "i'm micelle".data(using: .utf8)!) { error in
           if let error = error {
               print("Failed to save data: \(error)")
           } else {
               print("Data saved successfully")

           }
       }

    // for get data
   KServices.get(service: "myServices", account: "michelle") { data, error in
    if let error = error {
        print("Failed to retrieve data: \(error)")
    } else if let data = data, let dataString = String(data: data, encoding: .utf8) {
        print("Retrieved data: \(dataString)")
    } else {
        print("No data found")
    }
}

```

## Note this library support compile to object-c so u can use it in kotlin multiplatform

<a href="https://kotlinlang.org/docs/native-cocoapods.html"> See configuration cocoapods in gradle</a>

```gradle
kotlin {
    cocoapods {
        // Required properties
        // Specify the required Pod version here. Otherwise, the Gradle project version is used.
        version = "1.0"
        summary = "Some description for a Kotlin/Native module"
        homepage = "Link to a Kotlin/Native module homepage"

        // Optional properties
        // Configure the Pod name here instead of changing the Gradle project name
        name = "MyCocoaPod"

        framework {
            // Required properties
            // Framework name configuration. Use this property instead of deprecated 'frameworkName'
            baseName = "MyFramework"

             noPodspec()
             ios.deploymentTarget = "12.0"  // Update this to the required version


             pod("KServices") {
                version = "0.1.4"
                extraOpts += listOf("-compiler-option", "-fmodules")

             }
        }

    
    }
}
```

## Use in kotlin multiplatform iosMain or appleMain

```kotlin

@OptIn(BetaInteropApi::class)
internal fun String.nsdata(): NSData? =
    NSString.create(string = this).dataUsingEncoding(NSUTF8StringEncoding)

@OptIn(BetaInteropApi::class)
internal fun NSData.string(): String? =
    NSString.create(data = this, encoding = NSUTF8StringEncoding)?.toString()
@OptIn(ExperimentalForeignApi::class)

actual class KMMCrypto {
    actual fun saveData(key: String, group: String, data:String) {
        val nsData = data.nsdata() ?: NSData()

        KServices.saveWithService("test", "man" , nsData
        ) {
            println("data saved")
        }

    }

    actual   suspend fun loadData(key: String, group: String): String? {
        return suspendCancellableCoroutine { continuation ->
            KServices.getWithService("test", "man") { v, e ->
                if (e == null) {
                    val dataString = v?.string()
                    continuation.resume(dataString)  // Resume with the result
                } else {
                    val throwable = e as? Throwable ?: RuntimeException("Unknown error occurred")

                    continuation.resumeWithException(throwable)  // Resume with an exception
                }
            }
        }
    }

}
```

## Author

Michelle Raouf, <eng.michelle.raouf@gmail.com>

## License

KServices is available under the MIT license. See the LICENSE file for more info.
