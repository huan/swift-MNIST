# Swift MNIST Dataset

[![Build Status](https://travis-ci.com/huan/swift-MNIST.svg?branch=master)](https://travis-ci.com/huan/swift-MNIST)

![MNIST dataset](docs/images/swift-mnist.png)

Swift Module for [MNIST database (Modified National Institute of Standards and Technology database)](https://en.wikipedia.org/wiki/MNIST_database)

This module is made by the purpose of easy to use for the [Swift Chapter](https://github.com/tensorflow-handbook-swift) in [Tensorflow Handbook](https://tf.wiki).

## Usage

Class `MNIST` will provide all you need.

We have example demo code that you can run directly. Run our demo by:

```shell
git clone git@github.com:huan/swift-MNIST.git
cd swift-MNIST

# if you need docker environment to run swift:
# make docker

make demo
```

Output:

```sh
$ make docker
docker run -ti --rm \
  --privileged \
  --userns=host \
  -v "$(pwd)":/notebooks \
  zixia/swift \
  bash

root@b07ae41e460c:/notebooks#
root@b07ae41e460c:/notebooks# make demo
(cd examples && swift run)
[2/2] Merging module s4tf
Reading data.
Constructing data tensors.
Test Accuracy: 0.93633336
```

### `main.swift`

```swift
import MNIST

let mnist = MNIST()
let ((trainImages, trainLabels), (testImages, testLabels)) = mnist.loadData()

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
        .package(url: "https://github.com/huan/swift-MNIST.git", from: "0.4.0"),
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

## Talks

- [Convolutional Neural Networks with Swift (and 🐍) - Brett Koonce, Quarkworks CTO & ML GDE](http://static.brettkoonce.com/presentations/convolutional_neural_networks_swift.pdf) (slide)
- [Convolutional neural networks with Swift - Kirkland ML Summit ‘19 - Brett Koonce, CTO at Quarkworks and Google Developers Expert](https://www.youtube.com/watch?v=d6jZUYjHaWI) (video)

## History

### master

Add exmple code base in `examples/`, run the demo by `make demo`.

### 0.4.0 (12 Nov, 2019)

Fix the MNIST Dataset file 404 problem.

### 0.1.0 (28 Aug 2019)

First version, used from [Tensorflow Handbook for Swift](https://github.com/huan/tensorflow-handbook-swift)

## Links

- [Getting Started - Using the Package Manager](https://swift.org/getting-started/#using-the-package-manager)
- [Swift Package Manager Official Document](https://swift.org/package-manager/)
- [Swift Package Manager Usage](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md)
- [Handle dependencies with Swift Package Manager](https://www.codementor.io/marcinzbijowski/handle-dependencies-with-swift-package-manager-hx0ryac5u)
- [How to specify semver version for Swift Package](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md#methods-3)

## Author

[Huan](https://github.com/huan) [(李卓桓)](http://linkedin.com/in/zixia) <zixia@zixia.net>

[![Profile of Huan LI (李卓桓) on StackOverflow](https://stackoverflow.com/users/flair/1123955.png)](https://stackoverflow.com/users/1123955/huan)

## Copyright & License

- Code & Docs © 2019-now Huan LI (李卓桓) <zixia@zixia.net>
- Code released under the Apache-2.0 License
- Docs released under Creative Commons
