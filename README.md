# swift-dataset-mnist

MNIST Dataset Swift Module

## Usage

```swift
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

