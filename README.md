# Swift MNIST Dataset

![MNIST dataset](docs/images/mnist-example.png)

Swift Module for [MNIST database (Modified National Institute of Standards and Technology database)](https://en.wikipedia.org/wiki/MNIST_database)

## Usage

Class `MNIST` will provide all you need.

### `main.swift`

```swift
import MNIST

let mnist = MNIST()
let (trainImages, trainLabels, testImages, testLabels) = mnist.splitTrainTest()

let imageBatch = Dataset(elements: trainImages).batched(32)
let labelBatch = Dataset(elements: trainLabels).batched(32)

for (X, y) in zip(imageBatch, labelBatch) {
  // Caculate the gradient
  let (_, grads) = valueWithGradient(at: model) { model -> Tensor<Float> in
    let logits = model(X)
    return softmaxCrossEntropy(logits: logits, labels: y)
  }

  // Update parameters by optimizer
  optimizer.update(&model.self, along: grads)
}

let logits = model(testImages)
let acc = mnist.getAccuracy(y: testLabels, logits: logits)

print("Test Accuracy: \(acc)" )
```

Learn more from [Tensorflow Handbook for Swift](https://github.com/huan/tensorflow-handbook-swift)

### `Package.swift`

```swift
// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tensorflow-handbook-swift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/huan/swift-MNIST.git", from: "0.0.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "s4tf",
            dependencies: ["MNIST"]),
        .testTarget(
            name: "s4tfTests",
            dependencies: ["s4tf"]),
    ]
)
```

## Links

- [Getting Started - Using the Package Manager
](https://swift.org/getting-started/#using-the-package-manager)
- [Swift Package Manager Official Document](https://swift.org/package-manager/)

## Author

[Huan](https://github.com/huan) [(李卓桓)](http://linkedin.com/in/zixia) <zixia@zixia.net>

[![Profile of Huan LI (李卓桓) on StackOverflow](https://stackexchange.com/users/flair/265499.png)](https://stackexchange.com/users/265499)

## Copyright & License

- Code & Docs © 2019 - now Huan (李卓桓) <zixia@zixia.net>
- Code released under the Apache-2.0 License
- Docs released under Creative Commons

