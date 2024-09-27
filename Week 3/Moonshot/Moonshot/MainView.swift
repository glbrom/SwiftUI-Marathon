//
//  ContentView.swift
//  Moonshot
//
//  Created by Roman Golub on 26.09.2024.
//

import SwiftUI

struct MainView: View {
    @State private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columnsOfGrid = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let columnsOfList = [
        GridItem(.flexible(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: showingGrid ? columnsOfGrid : columnsOfList) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            showingGrid = true
                        } label: {
                            Label("Grid", systemImage: "square.grid.2x2")
                        }
                        
                        Button {
                            showingGrid = false
                        } label: {
                            Label("List", systemImage: "list.bullet")
                        }
                    } label: {
                        Image(systemName: showingGrid ? "square.grid.2x2" : "list.bullet")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
