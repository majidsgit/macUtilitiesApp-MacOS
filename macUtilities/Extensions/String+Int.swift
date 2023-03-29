//
//  String+Int.swift
//  macUtilities
//
//  Created by Majid on 30/03/2023.
//

import Foundation

extension String {
    
    func getMinutesNumber() -> Int {
        let seprated = self.components(separatedBy: ":")
        guard let hours = Int(seprated[0]) else { return 0 }
        guard let minutes = Int(seprated[1]) else { return 0 }
        return (hours * 60) + minutes
    }
}
