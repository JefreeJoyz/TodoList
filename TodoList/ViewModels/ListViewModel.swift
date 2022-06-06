//
//  ListViewModel.swift
//  TodoList
//
//  Created by Eugene Yakushev on 11.05.2022.
//

import Foundation

/*
 CRUD FUNCTIONS
 */

class ListViewModel: ObservableObject { // подписываем под протокол ObservableObject, что бы потом иметь возможность юзать @StateObject во вьюхах
    
    // До этого в примере у нас был "ручной" массив данных, обьявлен он был в главной вьюхе. Перемещаем его из вью - сюда. 
    @Published var items: [ItemModel] = [] {
        
        // kajdiy raz, kogda mi vizivaem items massiv - vizivaetsya didSet
        didSet {
            saveItems()
        }
    }
    // sozdaem peremennuyu, 4to bi ona bila nawim klyu4em dlya UserDefaults
    let itemsKey: String = "items_list"
    // Когда инициируется обьект класса - выполняется init (), который вызывает функцию getItems, которая создает 3 итема и пихает их в наш итем-массив items
    init() {
        getItems()
    }
    
    func getItems () {
//        let newItems = [
//            ItemModel.init(title: "This is the 1st", isComplited: false),
//            ItemModel.init(title: "This is the 2nd", isComplited: true),
//            ItemModel.init(title: "Third!", isComplited: false)
//        ]
//        items.append(contentsOf: newItems)    
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isComplited: false)
        items.append(newItem)
    }
    
    func updateItem (item:ItemModel) {
     //   sna4ala nado polu4it' | yznat' index
        // index - это будет первым индексом, где итем в массиве items будет иметь тот же ид, который передадут в аргументы
        
//        if let index = items.firstIndex { (existingItem) in
//            return existingItem.id == item.id
//        } {
//            // run this code
//        }
//        Eto analog koda stroki 44-45
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems () {
        // app storage uzaem vo view, a tyt - userDefaults
        
        // pitaemsya prevratit' items massiv v json data
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
