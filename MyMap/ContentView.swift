//
//  ContentView.swift
//  MyMap
//
//  Created by natsuko mizuno on 2024/02/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputText: String = ""
    @State var displaySearchKey: String = ""
    @State var displayMapType: MapType = .standard
    
    var body: some View {
        VStack {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    displaySearchKey = inputText
                }
                .padding()
            
            ZStack(alignment: .bottomTrailing) {
                MapView(searchKey: displaySearchKey,
                        mapType: displayMapType)
                //ボタン
                Button(action: {
                    // 標準　→　衛生写真　→ 衛生写真&交通機関ラベル、の順に表示
                    if displayMapType == .standard {
                        displayMapType = .satelite
                    } else if displayMapType == .satelite {
                        displayMapType = .hybrid
                    } else {
                        displayMapType = .standard
                    }
                }, label: {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                })
                .padding(.trailing, 20.0)
                .padding(.bottom, 30.0)
            }
        }
    }
}
#Preview {
    ContentView()
}
