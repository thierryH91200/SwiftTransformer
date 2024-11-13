//
//  ContentView.swift
//  test8
//
//  Created by Thierry hentic on 11/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var modele = MonModele()
    @State var flip : Bool = false

    var body: some View {

        VStack {
            Rectangle()
            // Get Value
                .fill(modele.backgroundColor)
                .frame(width: 100, height: 100)
                .border(modele.borderColor, width: 4)

            Text("Texte Exemple")
                .foregroundColor(modele.textColor)
            
            Button("Changer les couleurs") {
                
                if flip {
                    //  Set Value
                    modele.backgroundColor = Color.green
                    modele.textColor = Color.blue
                    modele.borderColor = Color.red
                    flip.toggle()
                } else {
                    modele.backgroundColor = Color.yellow
                    modele.textColor = Color.black
                    modele.borderColor = Color.pink
                    flip.toggle()
                }
            }
        }
        .padding()
    }
}
