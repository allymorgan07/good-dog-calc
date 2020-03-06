//
//  ViewController.swift
//  Good Dog Calculator
//
//  Created by ESTEBAN, ALEXANDRA (LYHS) on 1/17/20.
//  Copyright © 2020 Ally Esteban. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var dogView: UIImageView!
    @IBOutlet weak var outputText: UILabel!
    @IBOutlet weak var confidenceText: UILabel!
    
    var model: GoodDogCalc_1!
    var image: UIImage = UIImage(named: "puppy")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = GoodDogCalc_1()
        dogView.image = image
        confidenceText.text = nil
    }
    
    // begin cited code
    // https://medium.com/zipper-studios/how-to-add-a-machine-learning-model-to-your-ios-project-using-coreml-84d19f0ac524
    func classify() {
        let vnModel = try! VNCoreMLModel(for: model.model)
        let request = VNCoreMLRequest(model: vnModel) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                print("There are no results for this image")
                return
            }
            guard let firstObject = results.first else {
                print("There are no results for this image")
                return
            }
            
            let prediction = firstObject.identifier
            let confidence = firstObject.confidence
            
            self.updatePrediction(to: prediction, confidence: confidence)
        }
        
        let imageData = image.jpegData(compressionQuality: 0.5)
        
          do {
              try VNImageRequestHandler(data: imageData!, options: [:]).perform([request])
          } catch {
              print("There are no results for this image")
              print(error)
          }
    }
    //end cited code
    
    func updatePrediction(to prediction: String, confidence: Float) {
        let cleanPrediction = prediction.replacingOccurrences(of: "_", with: " ").lowercased()
        let cleanConfidence = Int(confidence * 100)
        outputText.text = "good \(cleanPrediction)!"
        confidenceText.text = "\(cleanConfidence)% confidence"
    }
    
    func openImageGallery() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        openImageGallery()
    }
    
    func newDog() {
        classify()
        dogView.image = image
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
            newDog()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
