//
//  TestVC.swift
//  GifBuilder
//
//  Created by Pietro Pepe on 9/19/15.
//  Copyright (c) 2015 Pietro Pepe. All rights reserved.
//

import UIKit

class TestVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate{

    
    var myView : MainView!;
    var contents : [UIImage]!;
    var faceView = [FaceView]();
    
    private var selectedCell : FaceView!;
    private var selectedIndex = 0;
    
    private var alert : UIAlertController!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        myView = MainView(frame: CGRect(origin: CGPointZero, size: view.frame.size));
        view.addSubview(myView);
        loadImgs();
        myView.collection.delegate = self;
        myView.collection.dataSource = self;
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeImg:", name: "putImg", object: nil);
        myView.collection.reloadData();
        myView.collection.reloadInputViews();
        
        applyGestures();
        //collectionView(myView.collection, didSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0));
        //myView.collection.selectItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None);
        //myView.prepareImgView();
        
        myView.okButton.addTarget(self, action: "saveAndPassToNext", forControlEvents: UIControlEvents.TouchUpInside);
        alert = UIAlertController(title: "Create new gif", message: "Enter the name of the gif", preferredStyle: UIAlertControllerStyle.Alert);
        alert.addTextFieldWithConfigurationHandler(nil);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: okAction));
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil));
    }
    
    private func changeImg(aNot : NSNotification){
        let index = aNot.object as! Int;
        myView.actualImg.image = contents[index];
        //myView.actualImg.image = img;
        //myView.collection.frameForItemAtIndex(<#index: Int#>)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : FrameItem =  collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath) as! FrameItem;
        cell.imgView.image = contents[indexPath.row];
        cell.setupCell(faceView[indexPath.row]);
        //println(indexPath.row);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row);
        if(myView.actualFace != nil){
            print("cmon");
            myView.actualFace.saveProperties(myView.actualImg.frame.size);
            myView.actualFace.removeFromSuperview();
            //saveFaceData();
        }
        selectFace(indexPath.row);
        myView.actualFace.calculateProperties(myView.actualImg.frame.size);
        myView.actualImg.addSubview(myView.actualFace);
        
        //(collectionView.cellForItemAtIndexPath(indexPath) as! FrameItem).setupCell(myView)
        
    }
    
    private func saveFaceData(){
        let face = myView.actualFace;
        let img = myView.actualImg;
        let targetFace = faceView[selectedIndex];
        
        let imgSize = img.frame.size; let faceSize = face.bounds.size;
        targetFace.taxSize = CGSize(width: (faceSize.width/imgSize.width)*2, height: faceSize.height/imgSize.height);
        
        let imgPos = face.center;
        targetFace.taxPos = CGPoint(x: imgPos.x/imgSize.width, y: imgPos.y/imgSize.height);
        targetFace.rotation = face.rotation;
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count;
    }
    
    private func loadImgs(){
        let f = CGRect(x: 0.5*view.frame.width, y: 0.5*view.frame.height, width: 0.4*view.frame.width, height: 0.4*view.frame.width);
        let s = "dimitri";
        contents = [UIImage]();
        for(var i=1; i<33; i++){
            let str = s+"\(i)";
            let img = UIImage(named: str)!;
            contents.append(img);
            faceView.append(FaceView(frame: f));
        }
        myView.actualImg.image = contents.first!;
    }
    
    private func selectFace(index : Int){
        selectedIndex = index;
        myView.actualImg.image = contents[index];
        myView.actualFace = faceView[index];
    }
    
    private func applyGestures(){
        
        let pan = UIPanGestureRecognizer(target: self, action: "drag:");
        let pinch = UIPinchGestureRecognizer(target: self, action: "pinch:");
        let rot = UIRotationGestureRecognizer(target: self, action: "rot:");
        view.gestureRecognizers = [pan,pinch,rot];
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
    func drag(gest : UIPanGestureRecognizer){
        //let location = gest.locationInView(myView.actualImg);
        let face = myView.actualFace;
        let v = gest.translationInView(myView.actualFace);
        gest.setTranslation(CGPointZero, inView: myView.actualFace);
        //myView.actualFace.frame.origin = CGPoint(x: myView.actualFace.frame.origin.x+v.x, y: myView.actualFace.frame.origin.y+v.y);
        face.transform = CGAffineTransformRotate(face.transform, -face.rotation);
        face.center = CGPoint(x: face.center.x+v.x, y: face.center.y+v.y);
        face.transform = CGAffineTransformRotate(face.transform, face.rotation);
        //myView.actualFace.transform = CGAffineTransformTranslate(myView.actualFace.transform, v.x, v.y);
        //myView.actualFace.center = location;
    }
    
    func pinch(gest : UIPinchGestureRecognizer){
        let s = gest.scale;
//        let aSize = myView.actualFace.frame.size;
//        myView.actualFace.frame.size = CGSize(width: aSize.width*s, height: aSize.height*s);
        gest.scale = 1;
        myView.actualFace.bounds.size = CGSizeMake(myView.actualFace.bounds.width*s, myView.actualFace.bounds.height*s);
        //myView.actualFace.transform = CGAffineTransformScale(myView.actualFace.transform, s, s);
        
    }
    
    func rot(gest : UIRotationGestureRecognizer){
        let r = gest.rotation;
        gest.rotation = 0;
        myView.actualFace.rotation += r;
        myView.actualFace.transform = CGAffineTransformRotate(myView.actualFace.transform, r);
        //println(myView.actualFace.rotation);
    }
    
    func saveAndPassToNext(){
        //saveFaceData();
        myView.actualFace.saveProperties(myView.actualImg.frame.size);
        if(selectedIndex < faceView.count-1){
            myView.actualFace.removeFromSuperview();
            selectedIndex++;
            faceView[selectedIndex] = myView.actualFace.copy2();
            myView.actualFace = faceView[selectedIndex];
            myView.actualImg.image = contents[selectedIndex];
            myView.actualFace.calculateProperties(myView.actualImg.frame.size);
            myView.actualImg.addSubview(myView.actualFace);
        }
        else{
            startSavingProcess();
        }
    }
    
    
    private func startSavingProcess(){
        presentViewController(alert, animated: true, completion: nil);
    }
    
    private func okAction(alert : UIAlertAction!)
    {
        let textField = self.alert.textFields?.first
        let name = textField?.text!
        let message : String;
        let title : String;
        if(name == ""){
            message = "Please enter a valid name"; title = "Error";
        }
        else{
            if(GifBuilderDAO.saveGif(faceView, imgs: contents)){
                message = "Saved successfully"; title = "Success";
            }
            else{
                message = "Error while saving \(name).plist, check for nil values"; title = "Error"
                
            }
        }
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        presentViewController(alert2, animated: true, completion: nil);
        alert2.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil));
    }
    
}
