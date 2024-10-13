//
//  ContentView.swift
//  HabitTracking
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var activityManager = ActivityManager()
    
    var body: some View {
        ActivityListView(showActivityListViewModel: ShowActivityListViewModel(activityManager: activityManager))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
