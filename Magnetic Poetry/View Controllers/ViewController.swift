// By Irvin Do and Kyle Lekkas
//  ViewController.swift
//  Magnetic Poetry
//
//  Created by Irvin Do on 1/30/18.
//  Copyright © 2018 Irvin Do and Kyle Lekkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var backgroundImage:UIImage?
    var wordSetBrain: WordSetBrain!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        placeWords(words: wordSetBrain.userSetDataArray)
        
        //same color as start screen
        view.backgroundColor = UIColor.init(red: 0.168, green: 0.541, blue: 0.560, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Finds all labels and returns them as a UILabel array
    func findLabels() -> [UILabel] {
        var labels = [UILabel]()
        
        for view in view.subviews{
            if (view is UILabel){
                labels += [view as! UILabel]
            }
        }

        
        return labels
    }

    
    //Removes every label from view
    func removeWords(){
        for view in view.subviews{
            if (view is UILabel){
                view.removeFromSuperview()
            }
        }
    }
    
    // Creates labels with text so they are properly sized then stores them so we can place them later.
    func setAndAppend(wordSet: [String]) -> [UserSetData] {
        var tempUserSet: [UserSetData] = []
        
        var xPlacement = 80
        var yPlacement = 50
        var yBuffer = 50
        let margin = 35
        
        //Determine font size based on device being used
        //Also adjust yPlacement
        //Default - phone and others
        var fontSize:CGFloat = 40
        
        //If they're using an ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            fontSize = 65
        }
            //If they're using a tv...
        else if UIDevice.current.userInterfaceIdiom == .tv {
            fontSize = 200
        }
        //yBuffer will space the words vertically to compensate for large fontSize
        yBuffer = Int(fontSize) + 20
        
        for words in wordSet {
            let label = UILabel()
            label.backgroundColor = UIColor.white
            label.text = words
            label.font = UIFont(name: "HelveticaNeue", size: fontSize)
            label.sizeToFit()
            
            if label.frame.width + CGFloat(margin) + CGFloat(xPlacement) > UIScreen.main.bounds.width {
                xPlacement = 80
                yPlacement += yBuffer
            }
            
            let x = margin + Int(xPlacement)
            xPlacement = x + Int(label.frame.width)
            
            let y = yPlacement
            label.center = CGPoint(x:x, y:y)
            if ( y <= Int(view.frame.height / 3)  ) {
                tempUserSet.append(UserSetData(text: label.text!, centerX: Int(label.center.x), centerY: Int(label.center.y)))
            }
        }
        
        return tempUserSet
    }
    
    //Places and Creates Labels based on an array of words
    func placeWords(words:[UserSetData] ) {
        
        //Determine font size based on device being used
        //Also adjust yPlacement
        //Default - phone and others
        var fontSize:CGFloat = 40
        
        //If they're using an ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            fontSize = 65
        }
            //If they're using a tv...
        else if UIDevice.current.userInterfaceIdiom == .tv {
            fontSize = 200
        }
        
        for word in words{
            let label = UILabel()
            label.backgroundColor = UIColor.white
            label.text = word.text
            label.font = UIFont(name: "HelveticaNeue", size: fontSize)
            label.sizeToFit()
            
            label.center.x = CGFloat(word.centerX!)
            label.center.y = CGFloat(word.centerY!)

            //temp constraint to fix iphone placement
            view.addSubview(label)
            
            label.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            label.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWordSegue"{
            let wordSetVC = segue.destination.childViewControllers[0] as! WordSetVC
            wordSetVC.title = "Choose a Word List"
        }
    }

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if (segue.identifier == "DoneTapped"){
            let wordSetVC = segue.source as! WordSetVC
            wordSetBrain.userSetDataArray = setAndAppend(wordSet: wordSetVC.selectedWordSet)
            removeWords()
            placeWords(words: wordSetBrain.userSetDataArray)
            wordSetBrain.categoryString = wordSetVC.selectedCategory
        }
    }
    
    //Action
    //Share screenshot of screen
    @IBAction func sharePressed(_ sender: Any) {
        let image = self.view.takeSnapshot()
        let textToShare = "Check out this awesome poem I made with Word River!"
        let linkToCode = NSURL(string: "https://github.com/IrvinTehDo/Magetic-Poetry")
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, linkToCode!, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        //For iPad
        let popoverMenyViewController = activityVC.popoverPresentationController
        popoverMenyViewController?.permittedArrowDirections = .any
        popoverMenyViewController?.barButtonItem = sender as? UIBarButtonItem
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    //Load new background from photos
    @IBAction func loadPressed(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: - UIIMagePickerController Delgate Methods -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .center
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func applicationWillResignActive(_ application: UIApplication){
        wordSetBrain.updateLabelPosistions(labels: findLabels())
    }
}

extension ViewController: WordSetBrainDelegate {
    func wordSetBrain(didChange wordSetBrain: WordSetBrain, userSet: [UserSetData] ) {
        print("Setting new values for labels")
        placeWords(words: userSet)
    }
}

