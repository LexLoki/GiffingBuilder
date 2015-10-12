//
//  GifBuilderDAO.swift
//  GiffingBuilder-iOS
//
//  Created by Pietro Ribeiro Pepe on 10/4/15.
//  Copyright (c) 2015 Pietro Pepe. All rights reserved.
//

import UIKit
import Foundation


class GifBuilderDAO{
    
    class func saveGif(gif : [FaceView], imgs : [UIImage]) -> Bool{
        
        let frames = NSMutableArray();
        let quant = gif.count;
        for(var i=0; i<quant; i++){
            let frame = gif[i];
            let frameInfo = NSDictionary(objects: [dictFromPoint(frame.taxPos), dictFromSize(frame.taxSize), frame.rotation], forKeys: ["position","size","rotation"]);
            frames.insertObject(frameInfo, atIndex: frames.count);
        }
        let dict = NSDictionary(objects: ["dmitriGif",frames], forKeys: ["name","framesInfo"]);
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = documentPath.stringByAppendingPathComponent("dmitriInfo.plist");
        
        print(dict);
        
        
        
        if(dict.writeToFile(path, atomically: true)){
            print("Document sucessfully created");
            return true;
        }
        else{
            print("Error saving document. Check for nil values");
            return false;
        }
        
    }
    
    class private func dictFromSize (size : CGSize) -> NSDictionary{
        return dictFromPoint(CGPointMake(size.width, size.height));
    }
    
    class private func dictFromPoint(point : CGPoint) -> NSDictionary{
        return NSDictionary(objects: [point.x,point.y], forKeys: ["x","y"]);
    }
    
}

let tela: CGRect = UIScreen.mainScreen().bounds

/* Tamando da tela */
let screenSize = tela.size

/* Largura da tela */
let screenWidth = screenSize.width

/* Altura da tela */
let screenHeight = screenSize.height

/* Altura da navigation */
let alturaNavigation = CGFloat(70)

/* Altura referente ao espaço livre*/
let alturaLivre = screenHeight - alturaNavigation

let tamanhoDaCelula = CGRectMake(0, 0, screenWidth/2 - 13, alturaLivre/4)

let azulPetroleo = UIColor(red: 70/255, green: 119/255, blue: 133/255, alpha: 1)

let vermelho = UIColor(red: 242/255, green: 90/255, blue: 93/255, alpha: 1)

let cinzaDeTras = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1)


extension String {
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathExtension(ext)
    }
}