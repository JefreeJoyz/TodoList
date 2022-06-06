//
//  TodoListApp.swift
//  TodoList
//
//  Created by Eugene Yakushev on 11.05.2022.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView { // Теперь все наши вьюхи обернуты в навигейшн вью
                ListView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(listViewModel) // Теперь все вью имеют доступ к модели listViewModel
        }
    }
}
