//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by Alliston Aleixo on 11/01/22.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
  // MARK: - Properties
  private var images = [PHAsset]()
  
  // MARK: - Override funcs
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatePhotos()
  }
  
  // MARK: - UICollectionView funcs
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "PhotoCollectionViewCell",
      for: indexPath) as? PhotoCollectionViewCell else {
      fatalError("PhotoCollectionViewCell not found")
    }
    
    let asset = self.images[indexPath.row]
    let manager = PHImageManager.default()
    
    manager.requestImage(
      for: asset,
         targetSize: CGSize(width: 128, height: 128),
         contentMode: .aspectFit,
         options: nil) { image, _ in
           DispatchQueue.main.async {
             cell.photoImageView.image = image
           }
         }
    
    return cell
  }
  
  // MARK: - Private funcs
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      if status == .authorized {
        let assets = PHAsset.fetchAssets(with: .image, options: nil)
        assets.enumerateObjects { (object, count, stop) in
          self?.images.append(object)
        }
        
        self?.images.reverse()
        
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      }
    }
  }
}
