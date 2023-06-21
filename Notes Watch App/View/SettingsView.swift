//
//  SettingsView.swift
//  Notes Watch App
//
//  Created by kirshi on 6/21/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Double = 1.0
    
    func update(){
        lineCount = Int(value)
    }
    
    func load(){
        value = Double(lineCount)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Settings")
            
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            Slider(value: Binding(get: {
                self.value
            }, set: { newValue in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
        }
        .onAppear {
            load()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
