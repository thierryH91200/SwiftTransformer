//
//  ContentView.swift
//  test8
//
//  Created by Thierry hentic on 11/11/2024.
//

import SwiftUI
import SwiftData
import AppKit

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query(sort: \EntityModel.name, animation: .bouncy) var folders: [EntityModel]

    @State var modele = EntityModel()
    @State var flip : Bool = false
    
    init() {
        let path = getSQLiteFilePath()
        print(path!)
    }

    var body: some View {

        VStack {
            Rectangle()
            // Get Value
                .fill(Color(modele.backgroundColor))
                .frame(width: 100, height: 100)
                .border(Color(modele.borderColor), width: 4)

            Text(modele.name)
                .foregroundColor(Color(modele.textColor))
            
            Button("Change the colors") {
                
                if flip {
                    //  Set Value
                    modele = folders[0]
                    flip.toggle()
                } else {
                    modele = folders[1]
                    flip.toggle()
                }
            }
        }
        .onAppear {
                preloadDataIfNeeded(modelContext: modelContext)
            }

        .padding()
    }
    func preloadDataIfNeeded(modelContext: ModelContext) {
        // Vérifie si des données existent déjà
        let existingModel = try? modelContext.fetch(FetchDescriptor<EntityModel>())
        guard existingModel?.isEmpty == true else { return }
        
        // Ajout de données d'exemple
        let modele1 = EntityModel()
        modele1.name = "Example1"
        modele1.backgroundColor = NSColor.green
        modele1.textColor = NSColor.blue
        modele1.borderColor = NSColor.red

        let modele2 = EntityModel()
        modele2.name = "Example2"
        modele2.backgroundColor = NSColor.yellow
        modele2.textColor = NSColor.black
        modele2.borderColor = NSColor.purple
        
        // Enregistrer les modeles
        modelContext.insert(modele1)
        modelContext.insert(modele2)
        
        try? modelContext.save()
    }

}
