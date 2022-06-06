//
//  NoItemsView.swift
//  TodoList
//
//  Created by Eugene Yakushev on 13.05.2022.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    var body: some View {
        ScrollView {
            VStack (spacing: 10){
                Text("There are no items")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are u a productive? add items to ur todo list")
                    .padding(.bottom, 20)
                NavigationLink(destination: AddView()) {
                    Text("add smth")
                        .foregroundColor(.primary)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? Color.red : Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: animate ? Color.red.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
                
            }
            .frame(maxWidth: 400) // что бы на айпадах выглядело норм, ограничиваем по ширине
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    func addAnimation () {
        guard !animate else { return } // убеждаемся, что animate не тру
        DispatchQueue.main.asyncAfter (deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                NoItemsView()
                    .navigationTitle("Title")
            }
            .preferredColorScheme(.dark)
            NavigationView {
                NoItemsView()
                    .navigationTitle("Title")
            }
            .preferredColorScheme(.light)
        }
    }
}
