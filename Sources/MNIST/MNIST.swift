import TensorFlow
import Python
import Foundation

public class MNIST {

  let mnistBaseURL = "https://raw.githubusercontent.com/tensorflow/swift-models/master/Datasets/MNIST/"
  let mnistFiles = ["train-images-idx3-ubyte", "train-labels-idx1-ubyte"]
  
  var images: Tensor<Float>?
  var labels: Tensor<Int32>?

  public init() {
    // convert into tensors
    (self.images, self.labels) = self.readMNIST(
      imagesFile: self.mnistFiles[0],
      labelsFile: self.mnistFiles[1]
    )
  }

  // Split data into training and test
  public func loadData() -> (
    (
      Tensor<Float>,
      Tensor<Int32>
    ),
    (
      Tensor<Float>,
      Tensor<Int32>
    )
  ) {
    let data = self.images!
    let labels = self.labels!

    let N = Int(data.shape[0])
    let split = Int(0.8 * Float(N))
    
    let trainX = data[0..<split]
    let trainY = labels[0..<split]
    
    let testX = data[split..<N]
    let testY = labels[split..<N]
    
    return (
      (trainX, trainY),
      (testX, testY)
    )
  }

  // report accuracy of a batch 
  public func getAccuracy (
    y:      Tensor<Int32>, 
    logits: Tensor<Float>
  ) -> Float{
    let out = Tensor<Int32>(logits.argmax(squeezingAxis: 1) .== y).sum().scalarized()
    return Float(out) / Float(y.shape[0])
  }

  private func download() {
    let urllibRequest = Python.import("urllib.request")

    for file in self.mnistFiles {
      if !(FileManager.default.fileExists(atPath: file)) {
        print("Downloading \(file) ...")
        let url = self.mnistBaseURL + file
        urllibRequest.urlretrieve(url, file)
      }
    }
  }

  /// Reads a file into an array of bytes.
  private func readFile(_ path: String) -> [UInt8] {
      let url = URL(fileURLWithPath: path)
      let data = try! Data(contentsOf: url, options: [])
      return [UInt8](data)
  }

  /// Reads MNIST images and labels from specified file paths.
  private func readMNIST(
    imagesFile: String,
    labelsFile: String
  ) -> (
    images: Tensor<Float>,
    labels: Tensor<Int32>
  ) {
    download()

    print("Reading data.")
    let images = readFile(imagesFile).dropFirst(16).map(Float.init)
    let labels = readFile(labelsFile).dropFirst(8).map(Int32.init)
    let rowCount = Int(labels.count)
    let imageHeight: Int = 28, imageWidth: Int = 28

    print("Constructing data tensors.")
    return (
        images: Tensor(shape: [rowCount, 1, imageHeight, imageWidth], scalars: images)
                .transposed(withPermutations: [0, 2, 3, 1]) / 255, // NHWC
        labels: Tensor(labels)
    )
  }
}
