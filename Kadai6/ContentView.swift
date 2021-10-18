//
//  ContentView.swift
//  Kadai6
//

import SwiftUI

struct ContentView: View {
    @State private var randomInt = Int.random(in: 1...100)
    @State private var sliderValue: Double = 50
    @State private var whitchAlert: AlertType = AlertType.incollect
    @State var onAlert: Bool = false

    enum AlertType {
        case collect
        case incollect
    }

    private func checkAnsewr() {
        whitchAlert = randomInt == Int(sliderValue) ? .collect : .incollect
    }

    private func restart() {
        self.randomInt = Int.random(in: 1...100)
        self.onAlert = false
        self.sliderValue = 50
    }

    var body: some View {
        VStack(spacing: 10) {
            Text("\(randomInt)").font(.largeTitle).bold()
            Spacer().frame(height: 10)
            Slider(value: $sliderValue, in: 1...100)
            HStack {
                Text("1")
                Spacer()
                Text("100")
            }
            Spacer().frame(height: 20)
            Button(action: {
                checkAnsewr()
                onAlert = true
            }, label: {
                Text("判定！")
            }).alert(isPresented: $onAlert) {
                let alertMessage: String
                switch whitchAlert {
                case.collect:
                    alertMessage = "あたり！\nあなたの値：\(Int(sliderValue))"
                case.incollect:
                    alertMessage = "はずれ！\nあなたの値：\(Int(sliderValue))"
                }
                return Alert(title: Text("結果"),
                             message: Text(alertMessage),
                             dismissButton: .default(Text("再挑戦"),
                                                     action: { restart() }))
            }
        }.padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
