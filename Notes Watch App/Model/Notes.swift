//
//  Notes.swift
//  Notes Watch App
//
//  Created by kirshi on 6/21/23.
//

import Foundation

struct Notes: Codable, Identifiable {
    let id: UUID
    let text: String
}
