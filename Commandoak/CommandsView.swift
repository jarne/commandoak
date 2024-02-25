//
//  ContentView.swift
//  Commandoak
//

import SwiftUI
import SwiftData

struct CommandsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var commands: [Command]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(commands) { cmd in
                    NavigationLink {
                        CommandDetailView(cmd: cmd)
                    } label: {
                        Text(cmd.icon)
                        Text(cmd.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Command()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(commands[index])
            }
        }
    }
}

#Preview {
    CommandsView()
        .modelContainer(for: Command.self, inMemory: true)
}
