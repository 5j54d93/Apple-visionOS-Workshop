//
//  SkySpherePickerView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/18.
//

import SwiftUI

struct SkySpherePickerView: View {
    
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 16),
                    count: 3
                ),
                spacing: 16
            ) {
                ForEach(SkySphereType.allCases, id: \.self) { skySphereType in
                    Button {
                        withAnimation {
                            appModel.skySphereType = skySphereType
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 16) {
                            Image(skySphereType.environmentImageName)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .bottomTrailing) {
                                    if skySphereType.hasHDRI {
                                        Text("HDRI")
                                            .font(.callout)
                                            .foregroundStyle(.primary)
                                            .padding(.vertical, 1)
                                            .padding(.horizontal, 6)
                                            .background(Material.thick)
                                            .cornerRadius(4)
                                            .padding(6)
                                    }
                                }
                            
                            HStack {
                                Text(skySphereType.title)
                                
                                Spacer()
                                
                                Text(Image(systemName: "checkmark.circle.fill"))
                                    .foregroundStyle(Color.green)
                                    .opacity(appModel.skySphereType == skySphereType ? 1 : 0)
                            }
                            .font(.headline)
                        }
                        .padding(8)
                    }
                    .buttonStyle(.plain)
                    .buttonBorderShape(.roundedRectangle)
                }
            }
            .padding(8)
        }
        .padding(.horizontal, 8)
    }
}
