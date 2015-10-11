//
//  FrameItem.swift
//  GifBuilder
//
//  Created by Pietro Pepe on 9/19/15.
//  Copyright (c) 2015 Pietro Pepe. All rights reserved.
//

import UIKit

class FrameItem: UICollectionViewCell {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do view setup here.
//        
//    }
    
    var imgView : UIImageView!;
    var index : Int!;
    
    var face : FaceView!;
    
    override init(frame: CGRect) {
        _ = Infos.sharedInstance.cellSize;
        super.init(frame: CGRect(origin: CGPointZero, size: frame.size));
        imgView = UIImageView(frame: CGRect(origin: CGPointZero, size: frame.size));
        
        contentView.addSubview(imgView);

    }
    
    func setupCell(face: FaceView){
        if(self.face != nil){
            self.face.removeFromSuperview();
        }
        //self.face = face.copy2();
        self.face = face.copy2();
        self.face.calculateProperties(contentView.frame.size);
        contentView.addSubview(self.face);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func selectCell(botone : UIButton){
//        NSNotificationCenter.defaultCenter().postNotificationName("putImg", object: index);
//    }
    
    
    func setImg(img : UIImage, index: Int){
        imgView.image = img;
        self.index = index;
    }
    
}
