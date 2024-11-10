//
//  FileManager.swift
//  Bucketlist
//
//  Created by Roman Golub on 13.10.2024.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
