import SwiftUI

struct ContentView: View {
    @AppStorage("count") private var count: Int = 0
    @AppStorage("stepSize") private var stepSize: Int = 1
    @AppStorage("multiplier") private var multiplier: Int = 1
    @AppStorage("hapticsOn") private var hapticsOn: Bool = true

    @State private var showSettings = false

    private var effectiveStep: Int { stepSize * multiplier }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 48) {
                    Spacer()

                    Text("\(count)")
                        .font(.system(size: 88, weight: .heavy, design: .monospaced))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.4)
                        .lineLimit(1)
                        .padding(.horizontal, 24)

                    Text("STEP \(effectiveStep)")
                        .font(.system(size: 13, weight: .semibold))
                        .tracking(3)
                        .foregroundColor(.white.opacity(0.5))

                    Spacer()

                    HStack(spacing: 24) {
                        RoundButton(symbol: "minus") {
                            change(by: -effectiveStep)
                        }
                        RoundButton(symbol: "plus") {
                            change(by: effectiveStep)
                        }
                    }
                    .padding(.bottom, 24)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(count: $count)
        }
    }

    private func change(by amount: Int) {
        count += amount
        if hapticsOn {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}

struct RoundButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .frame(width: 84, height: 84)
                .background(Circle().fill(Color.white))
        }
    }
}

#Preview {
    ContentView()
}
