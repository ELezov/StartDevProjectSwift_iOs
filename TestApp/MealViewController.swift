//
//  MealViewController.swift
//  TestApp
//
//  Created by KODE_H6 on 22.09.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    //Mark: Properties
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var fieldText: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var meal: Meal?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fieldText.delegate = self

        updateSaveButtonState()
    }

    //Mark : UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    //Mark : UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    //Mark : Navigation
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = fieldText.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating

        meal = Meal(name: name, photo: photo, rating: rating)
    }


    //Mark : Action
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        fieldText.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true,completion: nil)
    }

    //MARK: Private Methods

    func updateSaveButtonState(){
        let text = fieldText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

