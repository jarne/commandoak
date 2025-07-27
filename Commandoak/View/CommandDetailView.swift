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
                    .onChange(of: icon) { _, newState in
                        self.icon = String(newState.prefix(1))
                    }
                    .padding()
            }
            .textFieldStyle(.roundedBorder)
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
            VStack(alignment: .leading) {
                Text("Command")
                TextEditor(text: $execute)
                    .font(.system(.body, design: .monospaced))
                    .frame(height: 100)
            }
            .padding()
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
