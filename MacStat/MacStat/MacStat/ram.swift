//
//  ram.swift
//


import Foundation


class RAMUsage {
    
    let processInfo = ProcessInfo.processInfo
    
    func getRAM() {
        
        let physicalMemory = processInfo.physicalMemory
        let formatter = ByteCountFormatter()
        formatter.countStyle = .memory
        
        let formattedMemoryUsage = formatter.string(fromByteCount: Int64(physicalMemory))
        parseAndPrint(formattedMemoryUsage: formattedMemoryUsage)
    }
    func parseAndPrint(formattedMemoryUsage: String) {
        print("Formatted RAM usage: \(formattedMemoryUsage)")
        
        
        if let gigsOfRAM = parseFormattedRAMUsage(formattedUsage: formattedMemoryUsage) {
            
            print("RAM Usage in Gigabytes: \(gigsOfRAM) GB")
        } else {
            print("Could not retrieve or parse RAM usage")
        }
    }
    func parseFormattedRAMUsage(formattedUsage: String) -> Double? {
        let scanner = Scanner(string:  formattedUsage)
        var value: Double = 0.0
        var unit: NSString?
        
        if scanner.scanDouble(&value) {
            
            scanner.scanCharacters(from: .letters, into: &unit)
            
            if let unitString = unit as String?, unitString.lowercased() == "GB" {
                print("Parsed RAM Usage: \(value) GB")
                
                return value
            } else {
                print("could not parse and return value")
            }
            
        }
        return nil
        
    }
}
