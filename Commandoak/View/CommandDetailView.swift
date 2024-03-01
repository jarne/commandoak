//
//  CommandDetailView.swift
//  Commandoak
//

import SwiftUI

struct CommandDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var cmd: Command

    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var execute: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .padding()
                TextField("Icon", text: $icon)
                    .padding()
                TextField("Command", text: $execute)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Delete") {
                        withAnimation {
                            delete()
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                name = cmd.name
                icon = cmd.icon
                execute = cmd.execute
            }
            .id(cmd.id)
        }
    }

    init(cmd: Command) {
        self.cmd = cmd
    }

    private func save() {
        cmd.name = name
        cmd.icon = icon
        cmd.execute = execute
    }

    private func delete() {
        modelContext.delete(cmd)
    }
}

#Preview {
    CommandDetailView(cmd: Command(name: "Echo some text", icon: "📢", execute: "echo hello"))
}
