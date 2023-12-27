//
//  ContentView.swift
//  Navigation
//
//  Created by Pascal Sauer on 26.12.23.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }
    
    init(number: Int) {
        self.number = number
        
        print("Creating detail view \(number)")
    }
}

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct DetailView2: View {
    var number: Int
//    @Binding var path: [Int]
    @Binding var path: NavigationPath

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
//                    path.removeAll()
                    path = NavigationPath()
                }
            }
        
    }
}

struct ContentView: View {
//    @State private var path = [Int]()
//    @State private var path = NavigationPath()
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
//            List(0..<100) { i in
//                NavigationLink("Select \(i)", value: i)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
            
//            VStack {
//                Button("Show 32") {
//                    path = [32]
//                }
//                
//                Button("Show 64") {
//                    path.append(64)
//                }
//                
//                Button("Show 32 then 64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Select Number: \(i)", value: i)
//                }
//                
//                ForEach(0..<5) { i in
//                    NavigationLink("Select String: \(i)", value: String(i))
//                }
//            }
//            .toolbar {
//                Button("Push 556") {
//                    path.append(556)
//                }
//                
//                Button("Push Hello") {
//                    path.append("Hello")
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected the number \(selection)")
//            }
//            
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected the String \(selection)")
//            }
            DetailView2(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView2(number: i, path: $pathStore.path)
                }
        }
    }
}

#Preview {
    ContentView()
}
