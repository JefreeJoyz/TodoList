//
//  AddView.swift
//  TodoList
//
//  Created by Eugene Yakushev on 11.05.2022.
//

import SwiftUI

struct AddView: View {

    @Environment(\.presentationMode) var presentationMode // добавляем, что бы после "сейв" перейти сразу на главное меню
    @EnvironmentObject var listViewModel: ListViewModel // получаем доступ к классу
    @State var textFieldText: String = ""
    
    // Добавляем переменные для алерта
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type smth here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.primary)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

            }
            .padding(14)
        }
        .navigationTitle("Add an Item")
        .alert(isPresented: $showAlert) {
            getAlert()
        }
    }
    
    func saveButtonPressed () {
        if textIsAppropriate () { // сначала делаем валидацию
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    // добавляем валидацию на кол-во введенных символов.
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            // добавляем вызов алерта
            alertTitle = "Ur new item must be at least 3 char. long"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
        .environmentObject(ListViewModel())
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
        .environmentObject(ListViewModel())
        }
    }
}
