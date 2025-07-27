//
//  ContentView.swift
//  Commandoak
//

import SwiftUI
import SwiftData

struct CommandsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Command.position) private var commands: [Command]

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
                .onMove(perform: moveItems)
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add command", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a command to edit or create a new one")
        }
    }

    private func addItem() {
        withAnimation {
            let newCmd = Command(position: commands.count)
            modelContext.insert(newCmd)
        }
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        withAnimation {
            var sortedCommands = commands
            sortedCommands.move(fromOffsets: source, toOffset: destination)
            
            for (i, cmd) in sortedCommands.enumerated() {
                cmd.position = i
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
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
