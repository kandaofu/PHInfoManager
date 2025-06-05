//
//   DeviceManager.swift
//   PHInfoManager
//
//   Created by Apple on 2025/2/14
//
//
   

import UIKit

public class DeviceManager: NSObject {
    
    public static let shared = DeviceManager()
    
    //device info
    public static func getEncryptInfo(withID id:String,withKey key:String,isPrint:Bool=false) -> String {
        let info = DeviceInfoHelper.shared.setEncryptInfo(id: id, key: key, isPrint: isPrint)
        return info
    }
    
    //home pop up
    public static func setHomePop(withImageView popImage:UIImageView,buttonText:String,didSelect:@escaping(()->Void)){
        HomePopUpHelper.popShare.setPopUp(popImage: popImage, buttonText: buttonText, didSelect: didSelect)
    }
    
    //customer
    public func loadsCustom(with imageView:UIImageView,didClick:@escaping(()->Void)){
        CustomerHelper.shared.loadsCustom(with: imageView, didClick: didClick)
    }
    
    public func customShow(){
        CustomerHelper.shared.customerView?.show()
    }
    public func customHide(){
        CustomerHelper.shared.customerView?.hide()
    }
    
    
    
    
}
