//
//  UserDefaults.swift
//  HabitTracking
//
//  Created by Roman Golub on 13.10.2024.
//

import Foundation

extension UserDefaults {
    func getArray<T: Codable>(dataKey: String) -> [T] {
        if let data = self.data(forKey: dataKey) {
            if let items = try? JSONDecoder().decode([T].self, from: data) {
                return items
            } else {
                fatalError("FAILED")
            }
        } else {
            return [T]()
        }
    }
}
