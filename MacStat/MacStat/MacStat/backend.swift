//
//  backend.swift
//  MacStat
//
//  Created by alex haidar on 12/11/23.
//

import Foundation
import Cocoa
import IOKit
import IOKit.ps



class CPUTempWithServiceMatching {
    
    static func getCPUTemp() -> Double? {
        
        let dictionaryMatching = IOServiceMatching("AppleSMC")
        
        var service = IOServiceGetMatchingService(kIOMainPortDefault, dictionaryMatching)
        
        var temp = "0.0"
        
        if service != 0 {
            
            let key = "TC0P"   //thermal zone zero proxy
            
            if let result = IORegistryEntryCreateCFProperty(service, key as CFString, kCFAllocatorDefault, 0 ) {
                temp = (result.takeUnretainedValue() as! NSNumber).doubleValue.description
                IOObjectRelease(service)
                
                if let CPUTemp = Double(temp) {
                    print("CPU Temp: \(CPUTemp) °F")
                    return(CPUTemp)
                }
            }
            print("CPU temp °F could not be retrieved")
        }
        return nil
    }
}
  @main
struct program {
   static func main() {
        if let cpuTemp = CPUTempWithServiceMatching.getCPUTemp() {
            print("cpu temp\(cpuTemp) °F")
        } else {
            print("temps couldnot be displayed")
        }
    }
}
