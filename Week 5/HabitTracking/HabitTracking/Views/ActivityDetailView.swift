//
//  ActivityDetailView.swift
//  HabitTracking
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI

struct ActivityDetailView: View {
    @StateObject var showActivityDetailsVM: ShowActivityDetailsViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text(showActivityDetailsVM.selectedActivityItem.title)
                    .font(.title.bold())
                
                Text(showActivityDetailsVM.selectedActivityItem.description)
                    .multilineTextAlignment(.center)
                
                Rectangle()
                    .frame(width: 200, height: 2)
                    .background(Color.gray.opacity(0.2))
                
                HStack(alignment: .center) {
                    Text("You did \(showActivityDetailsVM.getCompletionCountDescription())")
                    Image(systemName: "minus.circle")
                        .foregroundColor(Color.accentColor)
                        .onTapGesture {
                            showActivityDetailsVM.decreaseCompletionCount()
                        }
                }
                
                Text("Just completed this activity?")
                
                HTButton(title: "Yes!") {
                    showActivityDetailsVM.increaseCompletionCount()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(20)
            
            Spacer()
        }
        .navigationTitle("Activity Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

