//
//  ActivityManager.swift
//  HabitTracking
//
//  Created by Roman Golub on 13.10.2024.
//

import Foundation

class ActivityManager: ObservableObject {
    @Published private var list: [ActivityItem] {
        didSet {
            if let data = try? JSONEncoder().encode(list) {
                UserDefaults.standard.set(data, forKey: activityItemsDataKey)
            }
        }
    }
    
    let activityItemsDataKey = "ActivityItems"
    
    init() {
        self.list = UserDefaults.standard.getArray(dataKey: activityItemsDataKey)
    }
    
    // MARK: - Extra Functions
    func getActivities() -> [ActivityItem] {
        return list
    }
    
    func deleteActivityById(_ id: UUID) {
        list = list.filter { item in
            return item.id != id
        }
    }
    
    func updateAnActivity(_ activityItem: ActivityItem) {
        guard let selectedIndex = list.firstIndex(of: activityItem) else {
            return
        }
        
        list[selectedIndex] = activityItem
    }
    
    func createNewActivity(_ newActivity: ActivityItem) {
        list.insert(newActivity, at: 0)
    }
}

