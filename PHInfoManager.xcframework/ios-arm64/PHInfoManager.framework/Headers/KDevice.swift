//
//   KDevice.swift
//   PHInfoManager
//
//   Created by Apple on 2025/10/1
//
//
   

import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreTelephony

public extension UIDevice{
    
    //MARK: - physicalMemory
    static var totalMemorySize:String {
        return ProcessInfo.processInfo.physicalMemory.stringValue
    }
    
    static var usedMemorySize: String {
        var usedBytes: Int64 = 0
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let kerr = withUnsafeMutablePointer(to: &info) { infoPtr -> kern_return_t in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        if kerr == KERN_SUCCESS {
            usedBytes = Int64(info.resident_size)
        }
        return usedBytes.stringValue
    }
    
    //MARK: - battery
    static var batteryChargeLevel: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(UIDevice.current.batteryLevel * 100)
    }
    
    static var isDeviceFull: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return batteryChargeLevel == 100 ? 1: UIDevice.current.batteryState == .full ? 1 : 0
    }
    
    static var isDeviceCharging: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .charging ? 1 : 0
    }
    
    
    //MARK: - ModelName
    static var deviceModelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let identifier = withUnsafePointer(to: &systemInfo.machine) { ptr in
            String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        return mapDevice(identifier: identifier)
    }
    
    private static func mapDevice(identifier: String) -> String {
        switch identifier {
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "iPhone 7"
        case "iPhone9,2":  return "iPhone 7 Plus"
            
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad6,11", "iPad6,12":  return "iPad 5"
        case "iPad11,1", "iPad11,2":  return "iPad Mini 5"
            
        case "iPhone9,3":  return "iPhone 7"
        case "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPhone11,8":  return "iPhone XR"
        
        case "iPhone12,5":  return "iPhone 11 Pro Max"
        case "iPhone12,8":  return "iPhone SE2"
        case "iPhone13,1":  return "iPhone 12 mini"
        
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
            
        case "iPhone11,2":  return "iPhone XS"
        case "iPhone11,6", "iPhone11,4":    return "iPhone XS Max"
        case "iPhone12,1":  return "iPhone 11"
        case "iPhone12,3":  return "iPhone 11 Pro"
            
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        
        case "iPad11,3", "iPad11,4":  return "iPad Air 3"
        case "iPad11,6", "iPad11,7":  return "iPad 8"
        case "iPad12,1", "iPad12,2":  return "iPad 9"
            
        case "iPhone13,2":  return "iPhone 12"
        case "iPhone15,3":  return "iPhone 14 Pro Max"
        case "iPhone15,4":  return "iPhone 15"
        case "iPhone15,5":  return "iPhone 15 Plus"
        case "iPhone16,1":  return "iPhone 15 Pro"
        case "iPhone16,2":  return "iPhone 15 Pro Max"
        case "iPhone17,1":  return "iPhone 16"
        case "iPhone13,3":  return "iPhone 12 Pro"
        case "iPhone13,4":  return "iPhone 12 Pro Max"
        case "iPhone14,4":  return "iPhone 13 mini"
        case "iPhone14,5":  return "iPhone 13"
        case "iPhone14,2":  return "iPhone 13 Pro"
        case "iPhone14,3":  return "iPhone 13 Pro Max"
        case "iPhone14,7":  return "iPhone 14"
        case "iPhone14,8":  return "iPhone 14 Plus"
        case "iPhone15,2":  return "iPhone 14 Pro"
        case "iPhone17,2":  return "iPhone 16 Plus"
        case "iPhone17,3":  return "iPhone 16 Pro"
        case "iPhone17,4":  return "iPhone 16 Pro Max"
            
        case "i386","x86_64":   return "Simulator"
            
        case "iPad13,1", "iPad13,2":  return "iPad Air 4"
        case "iPad14,1", "iPad14,2":  return "iPad Mini 6"
        case "iPad13,4 ~ 13,7":return "iPad Pro 11-inch 3nd gen"
        case "iPad13,8 ~ 13,11":return "iPad Pro 12.9-inch 5th gen"
        case "iPad13,16","iPad13,17":return "iPad Air 5"
        case "iPad7,1", "iPad7,2":  return "iPad Pro 12.9 inch 2nd gen"
        case "iPad7,3", "iPad7,4":  return "iPad Pro 10.5 inch"
        case "iPad7,5", "iPad7,6":  return "iPad 6"
        case "iPad7,11", "iPad7,12":  return "iPad 7"
        case "iPad8,1 ~ 8,4":  return "iPad Pro 11-inch"
        case "iPad8,5 ~ 8,8":  return "iPad Pro 12.9-inch 3rd gen"
        case "iPad8,9 ~ 8,10":  return "iPad Pro 11-inch 2nd gen"
        case "iPad8,11 ~ 8,12":  return "iPad Pro 12.9-inch 4th gen"
        case "iPad13,18","iPad13,19":return "iPad 10"
        case "iPad14,3 ~ 14,4":return "iPad Pro 11-inch 4th gen"
        case "iPad14,5 ~ 14,6":return "iPad Pro 12.9-inch 6th gen"
            
        default:  return identifier
        }
    }
    
    
    //MARK: - VPN
    static var isConnectedUsingVPN: Int {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return 0 }
        guard let dict = proxy as? [String: Any] else { return 0 }
        guard let scopedDict = dict["__SCOPED__"] as? [String: Any] else { return 0 }
        for key in scopedDict.keys {
            if (key == "tap") || (key == "tun") || (key == "ppp") || (key == "ipsec") || (key == "ipsec0") {
                return 1
            }
        }
        return 0

    }
    
    //MARK: - device size
    static var width:CGFloat{
        return UIScreen.main.bounds.size.width
    }

    static var height:CGFloat{
        return UIScreen.main.bounds.size.height
    }
    
    static var nativeWidth:CGFloat{
        return UIScreen.main.nativeBounds.size.width
    }

    static var nativeHeight:CGFloat{
        return UIScreen.main.nativeBounds.size.height
    }
    
    static var nativeSize:CGFloat{
        return sqrt(nativeWidth*nativeWidth + nativeHeight*nativeHeight)
    }
    
    static var safeTop:CGFloat{
        return UIWindow.top?.safeAreaInsets.top ?? 0
    }
    
    static var safeBottom:CGFloat{
        return UIWindow.top?.safeAreaInsets.bottom ?? 0
    }
    
    //MARK: - Simulator
    static var isRunningOnSimulator: Int {
#if targetEnvironment(simulator)
        return 1
#else
        return 0
#endif
    }
    
    //MARK: - isJailbroken
    static var isDeviceJailbroken: Int {
        let appPath = "/Applications/"
        if FileManager.default.fileExists(atPath: appPath),
           let apps = try? FileManager.default.contentsOfDirectory(atPath: appPath),
           !apps.isEmpty {
            return 1
        }
        return 0
    }
    
    //MARK: - preferredLanguages
    static var currentLanguageCode: String {
        NSLocale.preferredLanguages.first?.components(separatedBy: "-").first ?? ""
    }
    
    //MARK: - userInterfaceIdiom
    static var phoneType:Int{
        return UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
    }
    
    //MARK: - timeZone - abbreviation
    static var timeZone:String{
        return TimeZone.current.abbreviation() ?? ""
    }
    
    //MARK: - systemVersion
    static var release:String{
        return UIDevice.current.systemVersion
    }
    
    //MARK: - networkType
    static var networkType:String {
        var zeroAddress = sockaddr_storage()
        bzero(&zeroAddress, MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_len = UInt8(MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return "NONE"
        }

        var flags = SCNetworkReachabilityFlags()
        guard SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags),
              flags.contains(.reachable),
              !flags.contains(.connectionRequired) else {
            return "NONE"
        }

        if flags.contains(.isWWAN) {
            let networkInfo = CTTelephonyNetworkInfo()

            guard let radioType = networkInfo.currentRadioAccessTechnology else {
                return "OTHER"
            }

            if #available(iOS 14.1, *) {
                switch radioType {
                case CTRadioAccessTechnologyNRNSA, CTRadioAccessTechnologyNR:
                    return "5G"
                case CTRadioAccessTechnologyLTE:
                    return "4G"
                case CTRadioAccessTechnologyWCDMA,
                     CTRadioAccessTechnologyHSDPA,
                     CTRadioAccessTechnologyHSUPA,
                     CTRadioAccessTechnologyCDMAEVDORev0,
                     CTRadioAccessTechnologyCDMAEVDORevA,
                     CTRadioAccessTechnologyCDMAEVDORevB:
                    return "3G"
                case CTRadioAccessTechnologyGPRS,
                     CTRadioAccessTechnologyCDMA1x,
                CTRadioAccessTechnologyEdge:
                    return "2G"
                default:
                    return "OTHER"
                }
            } else {
                switch radioType {
                case CTRadioAccessTechnologyLTE:
                    return "4G"
                case CTRadioAccessTechnologyWCDMA,
                     CTRadioAccessTechnologyHSDPA,
                     CTRadioAccessTechnologyHSUPA,
                     CTRadioAccessTechnologyCDMAEVDORev0,
                     CTRadioAccessTechnologyCDMAEVDORevA,
                     CTRadioAccessTechnologyCDMAEVDORevB:
                    return "3G"
                case CTRadioAccessTechnologyGPRS,
                     CTRadioAccessTechnologyCDMA1x,
                CTRadioAccessTechnologyEdge:
                    return "2G"
                default:
                    return "OTHER"
                }
            }
        } else {
            return "WIFI"
        }
    }
    
    
    //MARK: - wifiName
    static var wifiName: String {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else { return "" }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else { return "" }
        var SSID: String = ""
        for interface in swiftInterfaces {
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else { return "" }
            
            guard let ssid = SSIDDict["SSID"] as? String else { return "" }
            SSID = ssid
        }
        return SSID

    }
    
    //MARK: - wifiMac
    static var wifiMac: String {
        guard let interfaces = CNCopySupportedInterfaces() else { return "" }
        guard let faceArray = (interfaces as NSArray) as? [String] else { return "" }
        var BSSID: String = ""
        for interface in faceArray {
            guard let faceInfo = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let faceSSIDict = (faceInfo as NSDictionary) as? [String: AnyObject] else { return "" }
            guard let bssid = faceSSIDict["BSSID"] as? String else { return "" }
            let stringArray = bssid.components(separatedBy: ":")
            var idValue: String = ""
            for (i, string) in stringArray.enumerated() {
                if i == 0 {
                    idValue = string
                }else {
                    if string.count == 1 {
                        idValue += String(format: ":0%@", string)
                    } else {
                        idValue += String(format: ":%@", string)
                    }
                }
            }
            BSSID = idValue
        }
        return BSSID
    }
    
    //MARK: - isProxy
    static var isProxyServerEnabled: Int {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else {
            return 0
        }
        guard let dict = proxy as? [String: Any] else {
            return 0
        }
        guard let HTTPProxy = dict["HTTPProxy"] as? String else {
            return 0
        }
        return HTTPProxy.count > 0 ? 1 : 0

    }
    
    
    //MARK: - systemSize
    static var totalDiskSize: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last ?? "") {
            if let total = dictionary[.systemSize] as? NSNumber {
                let totalSize = total.uint64Value
                return totalSize.stringValue
            }
        }
        return "0"
    }
    
    static var freeDiskSize: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last ?? "") {
            if let free = dictionary[.systemFreeSize] as? NSNumber {
                let freeSize = free.uint64Value
                return freeSize.stringValue
            }
        }
        return "0"
    }
    
    //MARK: - IP
    static var deviceIpAddress: String {
        var address = "127.0.0.1"
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                if let interface = ptr?.pointee,
                   interface.ifa_addr.pointee.sa_family == UInt8(AF_INET),
                   String(cString: interface.ifa_name) == "en0" {
                    address = String(cString: inet_ntoa((interface.ifa_addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0 }).pointee.sin_addr))
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
}

class KDevice: NSObject {

}
