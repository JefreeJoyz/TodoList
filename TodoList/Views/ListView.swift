//
//  ListView.swift
//  TodoList
//
//  Created by Eugene Yakushev on 11.05.2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Todo List")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView() )
            }
            
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Это необходимо, что бы на превью у нас было тоже самое, что и в эмуляторе
            ListView()
        }
        .preferredColorScheme(.light)
        .previewDevice("iPhone 13")
        .environmentObject(ListViewModel())
        .previewInterfaceOrientation(.portrait) // т.к. в превью нет @EnvironmentObject - добавляем его
    }
}


