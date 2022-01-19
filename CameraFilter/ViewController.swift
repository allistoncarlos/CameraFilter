//
//  ViewController.swift
//  CameraFilter
//
//  Created by Alliston Aleixo on 11/01/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var photoImageView: UIImageView!
  
  // MARK: - Properties
  private let disposeBag = DisposeBag()
  
  // MARK: - Override funcs
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navigationController =
            segue.destination as? UINavigationController,
          let photosCollectionViewController =
            navigationController.viewControllers.first as? PhotosCollectionViewController
    else { fatalError("Segue destination is not found") }
    
    photosCollectionViewController.selectedPhoto.subscribe(onNext: { [weak self] photo in
      self?.photoImageView.image = photo
    }).disposed(by: disposeBag)
  }
}

