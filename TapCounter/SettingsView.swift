import SwiftUI

struct SettingsView: View {
    @Binding var count: Int

    @AppStorage("stepSize") private var stepSize: Int = 1
    @AppStorage("multiplier") private var multiplier: Int = 1
    @AppStorage("hapticsOn") private var hapticsOn: Bool = true

    @Environment(\.dismiss) private var dismiss
    @State private var showResetConfirm = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                List {
                    Section {
                        Stepper(value: $stepSize, in: 1...100) {
                            SettingRow(title: "Step Size", value: "\(stepSize)")
                        }

                        Stepper(value: $multiplier, in: 1...20) {
                            SettingRow(title: "Multiplier", value: "\(multiplier)x")
                        }

                        Toggle(isOn: $hapticsOn) {
                            SettingRow(title: "Haptic Feedback", value: hapticsOn ? "On" : "Off")
                        }
                        .tint(.white)
                    }
                    .listRowBackground(Color(white: 0.1))

                    Section {
                        Button(role: .destructive) {
                            showResetConfirm = true
                        } label: {
                            Text("Reset Counter")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .listRowBackground(Color(white: 0.1))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .confirmationDialog(
                "Reset counter to 0?",
                isPresented: $showResetConfirm,
                titleVisibility: .visible
            ) {
                Button("Reset", role: .destructive) {
                    count = 0
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.white.opacity(0.5))
        }
    }
}

#Preview {
    SettingsView(count: .constant(0))
}
