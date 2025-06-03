

import UIKit

public class PHInfoManager: NSObject {
    public static func setDeviceJson(fvID:String,encryptionKey:String) -> String {
        let info = PHDeviceInfo.setDeviceJson(fvID: fvID, encryptionKey: encryptionKey)
        return info
    }
    
    public static func setHomePop(popImage:UIImageView,closeText:String,didSelect:@escaping(()->Void)){
        PHHomeGetPopUp.popShare.setPopUp(popImage: popImage, closeText: closeText, didSelect: didSelect)
    }
    
    public static func loadsCustom(with imageView:UIImageView,didClick:@escaping(()->Void)){
        PHWindsHelper.shared.loadsCustom(with: imageView, didClick: didClick)
    }
    
    public static func customShow(){
        show()
    }
    public static func customHide(){
        hide()
    }
    
    static func show(){
        PHWindsHelper.shared.windsView?.show()
    }
    static func hide(){
        PHWindsHelper.shared.windsView?.hide()
    }
    
}
