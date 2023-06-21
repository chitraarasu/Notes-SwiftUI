//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by kirshi on 6/21/23.
//

import SwiftUI

struct CreditsView: View {
    
    @State private var randomNumber: Int = Int.random(in: 1..<3)
    
    var body: some View {
        VStack(spacing: 3) {
            Image("developer-no\(randomNumber)")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            HeaderView(title: "Credits")
            
            Text("Chitraarasu k")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
