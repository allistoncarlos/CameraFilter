//
//  FilterService.swift
//  CameraFilter
//
//  Created by Alliston Aleixo on 19/01/22.
//

import UIKit
import CoreImage

class FilterService {
  private var context: CIContext
  
  init() {
    self.context = CIContext()
  }
  
  func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
    if let filter = CIFilter(name: "CICMYKHalftone") {
      filter.setValue(5.0, forKey: kCIInputWidthKey)
      
      if let sourceImage = CIImage(image: inputImage) {
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if let cgImg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
          let processedImage = UIImage(
            cgImage: cgImg,
            scale: inputImage.scale,
            orientation: inputImage.imageOrientation)
          completion(processedImage)
        }
      }
    }
  }
}
