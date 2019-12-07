//
//  ViewController.swift
//  Saving Image in Core Data
//
//  Created by Amit Rai on 07/12/19.
//  Copyright © 2019 Amit Rai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var saveImageView: UIImageView!
    @IBOutlet weak var fetchImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonPressed))
        saveImageView.layer.cornerRadius = 12
        fetchImageView.layer.cornerRadius = 12

    }

    @objc func cameraButtonPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        saveImageView.image = userPickedImage

        picker.dismiss(animated: true)
    }

    @IBAction func saveImageButtonPressed(_ sender: UIButton) {
        if let imageData = saveImageView.image?.pngData() {
            DataBaseHelper.shareInstance.saveImage(data: imageData)
        }
    }

    @IBAction func fetchImageButtonPressed(_ sender: UIButton) {

        let arr = DataBaseHelper.shareInstance.fetchImage()
        fetchImageView.image = UIImage(data: arr[0].img!)
    }
}
