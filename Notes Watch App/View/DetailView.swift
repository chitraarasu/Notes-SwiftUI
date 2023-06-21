//
//  DetailView.swift
//  Notes Watch App
//
//  Created by kirshi on 6/21/23.
//

import SwiftUI

struct DetailView: View {
    
    let note: Notes
    let count: Int
    let index: Int
    
    @State private var isCreditsPresented: Bool = true
    @State private var isSettingPresented: Bool = true
    
    var body: some View {
        VStack {
            HeaderView()
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingPresented) {
                        SettingsView()
                    }
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditsPresented) {
                        CreditsView()
                    }
            }
        }
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note: Notes(id: UUID(), text:
                                "Hello World"), count: 5, index: 1)
    }
}
