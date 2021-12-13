NSObject+Combine
===========

If you're using `Combine`, you've probably encountered the following code more than a few times.

```swift
class MyObject: Whatever {
    var cancellable: Set<AnyCancellable>

	...
}
```

You're actually not the only one; it has been typed many, many times.

Instead of adding a new property to every object, use this library to add it for you, to any subclass of `NSObject`.

```swift
thing
  .sink { ... }
  .store(in: &cancellable)
```

Sweet.

It'll work just like a property: when the instance is deinit'd, the `Cancellable` gets disposed. It's also a read/write property, so you can use your own, too.

If you want to add a Cancellable to an Object that does not inherit from NSObject, you can also implement the protocol `HasCancellable`, and you're good to go. This protocol provides a default Cancellable called `cancellable`.

Installing
----------

#### CocoaPods

Add to your `Podfile`:

```ruby
pod 'NSObject+Combine'
```

And that'll be 👌

Contributing
------------

Source files are in the root directory. We use CocoaPods to develop, check out the unit tests in the Demo project.

License
-------

MIT obvs.

![Tim Cook dancing to the sound of a permissive license.](http://i.imgur.com/mONiWzj.gif)
