//
//  ContentView.swift
//  Notes Watch App
//
//  Created by kirshi on 6/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var notes: [Notes] = [Notes]()
    @State private var text: String = ""
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        withAnimation {
            do {
                let data = try JSONEncoder().encode(notes)
                
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                try data.write(to: url)
            } catch {
                print("Saving data has failed!")
            }
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do {
                
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                let data = try Data(contentsOf: url)
                
                notes = try JSONDecoder().decode([Notes].self, from: data)
                
            } catch {
                print("Saving data has failed!")
            }
        }
    }
    
    func delete(offset: IndexSet){
        withAnimation {
            notes.remove(atOffsets: offset)
            save()
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Add New Note", text: $text)
                    Button {
                        guard !text.isEmpty else { return }
                        
                        notes.append(Notes(id: UUID(), text: text))
                        
                        text = ""
                    
                        save()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
//                    .buttonStyle(BorderedButtonStyle(tint: .accentColor))

                }
                
                Spacer()
                
                if !notes.isEmpty {
                    List {
                        ForEach(notes) { note in
                            NavigationLink(destination: DetailView(note: note, count: notes.count, index: notes.firstIndex(where: {$0.id == note.id}) ?? 0)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 3)
                                        .foregroundColor(.accentColor)
                                    Text(note.text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }
                            }
                        }.onDelete(perform: delete)
                        .scrollIndicators(ScrollIndicatorVisibility.hidden)
                        
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
