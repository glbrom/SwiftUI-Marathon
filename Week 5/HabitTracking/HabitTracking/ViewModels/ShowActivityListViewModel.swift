//
//  ShowActivityListViewModel.swift
//  HabitTracking
//
//  Created by Roman Golub on 13.10.2024.
//

import Foundation

class ShowActivityListViewModel: ObservableObject {
    private var activityManager: ActivityManager
    
    init(activityManager: ActivityManager) {
        self.activityManager = activityManager
    }
    
    func getActivityManager() -> ActivityManager {
        return activityManager
    }
    
    func getActivities() -> [ActivityItem] {
        activityManager.getActivities()
    }
    
    func deleteActivityById(_ id: UUID) {
        activityManager.deleteActivityById(id)
    }
}
