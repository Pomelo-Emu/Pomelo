//
//  AdvancedSettingsView.swift
//  Pomelo
//
//  Created by Stossy11 on 14/7/2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct AdvancedSettingsView: View {
    @AppStorage("isfullscreen") var isFullScreen: Bool = false
    @AppStorage("exitgame") var exitgame: Bool = false
    @AppStorage("ClearBackingRegion") var kpagetable: Bool = true
    @AppStorage("WaitingforJIT") var waitingJIT: Bool = false
    @State private var showFileImporter = false
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color(uiColor: UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(width: .infinity, height: 50)
                .overlay() {
                    HStack {
                        Toggle("FullScreen", isOn: $isFullScreen)
                            .padding()
                    }
                }
            Text("This is unstable and can lead to crashes. Use at your own risk.")
                .padding(.bottom)
                .font(.footnote)
                .foregroundColor(.gray)
            Rectangle()
                .fill(Color(uiColor: UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(width: .infinity, height: 50)
                .overlay() {
                    HStack {
                        Toggle("Exit Game Button", isOn: $exitgame)
                            .padding()
                    }
                }
            Text("This is very unstable and can lead to game freezing and overall bad preformance after you exit a game")
                .padding(.bottom)
                .font(.footnote)
                .foregroundColor(.gray)
            Rectangle()
                .fill(Color(uiColor: UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(width: .infinity, height: 50)
                .overlay() {
                    HStack {
                        Toggle("Ram Usage Decrease", isOn: $kpagetable)
                            .padding()
                            .onChange(of: kpagetable) { NewValue in
                                UserDefaults.standard.setValue(NewValue, forKey: "ClearBackingRegion")
                            }
                    }
                }
            Text("This is a bit unstable but can lead to slower preformance but also can allow for a bunch more games to be playable")
                .padding(.bottom)
                .font(.footnote)
                .foregroundColor(.gray)
            Rectangle()
                .fill(Color(uiColor: UIColor.secondarySystemBackground)) // Set the fill color (optional)
                .cornerRadius(10) // Apply rounded corners
                .frame(width: .infinity, height: 50) // Set the desired dimensions
                .overlay() {
                    HStack {
                        Toggle("Bypass Waiting for JIT Popup", isOn: $waitingJIT)
                            .padding()
                            
                    }
                }
            Text("This can cause crashes if you forget you didnt have JIT or something")
                .padding(.bottom)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Button {
                showFileImporter = true
            } label: {
                Rectangle()
                    .fill(Color(uiColor: UIColor.secondarySystemBackground)) // Set the fill color (optional)
                    .cornerRadius(10) // Apply rounded corners
                    .frame(width: .infinity, height: 50) // Set the desired dimensions
                    .overlay() {
                        HStack {
                            Text("Custom Directory")
                                .foregroundColor(.primary)
                                .padding()
                            Spacer()
                                
                        }
                    }
            }
            .padding(.bottom)
            
            Button {
                let user = UserDefaults.standard
                user.setValue(nil, forKey: "SudachiDirectoryURL")
            } label: {
                Rectangle()
                    .fill(Color(uiColor: UIColor.secondarySystemBackground)) // Set the fill color (optional)
                    .cornerRadius(10) // Apply rounded corners
                    .frame(width: .infinity, height: 50) // Set the desired dimensions
                    .overlay() {
                        HStack {
                            Text("Reset Directory")
                                .foregroundColor(.primary)
                                .padding()
                            Spacer()
                                
                        }
                    }
            }
        }
        .fileImporter(
            isPresented: $showFileImporter,
            allowedContentTypes: [.folder],
            allowsMultipleSelection: false
        ) { result in
            if case .success(let url) = result {
                // Handle the selected folder URL
                let user = UserDefaults.standard
                user.setValue(url.first!.absoluteString, forKey: "SudachiDirectoryURL")
            }
        }
    }
}
