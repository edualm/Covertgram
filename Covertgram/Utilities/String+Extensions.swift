//
//  String+Extensions.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import Foundation

extension String {
    
    //  https://stackoverflow.com/a/31727051
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    var decodedUnicodeString: String {
        guard let data = self.replacingOccurrences(of: "\\n", with: "\n").data(using: .utf8) else {
            return self
        }
        
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
}
