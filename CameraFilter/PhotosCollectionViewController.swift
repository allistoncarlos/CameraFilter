//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by Alliston Aleixo on 11/01/22.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatePhotos()
  }
  
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { status in
      if status == .authorized {
        
      }
    }
  }
}
