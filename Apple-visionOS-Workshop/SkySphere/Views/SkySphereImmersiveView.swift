//
//  SkySphereImmersiveView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/11.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SkySphereImmersiveView: View {
    
    @Environment(AppModel.self) private var appModel
    
    @State private var skySphereType = SkySphereType.allCases.first
    @State private var isShowEnvironmentPicker = false
    
    let sphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.2), materials: [SimpleMaterial(color: .white, roughness: 0, isMetallic: true)])
    
    var body: some View {
        RealityView { content, attachments in
            guard let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) else { return }
            content.add(immersiveContentEntity)
            
            sphere.position = [0, 1, -2]
            content.add(sphere)
            
            if let toggleImmersiveSpaceButtonAttachment = attachments.entity(for: "Toolbar") {
                sphere.addChild(toggleImmersiveSpaceButtonAttachment)
                toggleImmersiveSpaceButtonAttachment.scale = [3, 3, 3]
                toggleImmersiveSpaceButtonAttachment.position.y = sphere.position.y - 1.3
            }
            
            if let skySphere = immersiveContentEntity.findEntity(named: "SkySphere") as? ModelEntity {
                guard let environmentImageName = appModel.skySphereType?.environmentImageName,
                      let textureResource = try? await TextureResource(named: environmentImageName)
                else { return }
                let material = UnlitMaterial(texture: textureResource)
                skySphere.model?.materials = [material]
            }
            
            if let ibl = immersiveContentEntity.findEntity(named: "Image_Based_Light") {
                guard let hdriImageName = appModel.skySphereType?.hdriImageName,
                      let environmentResource = try? await EnvironmentResource(named: hdriImageName)
                else { return }
                ibl.components.set(ImageBasedLightComponent(source: .single(environmentResource)))
                sphere.components.set(ImageBasedLightReceiverComponent(imageBasedLight: ibl))
            }
        } update: { content, attachments in
            if let entity = content.entities.first {
                Task {
                    if let skySphere = entity.findEntity(named: "SkySphere") as? ModelEntity {
                        guard let environmentImageName = appModel.skySphereType?.environmentImageName,
                              let textureResource = try? await TextureResource(named: environmentImageName)
                        else { return }
                        let material = UnlitMaterial(texture: textureResource)
                        skySphere.model?.materials = [material]
                    }
                    
                    if let ibl = entity.findEntity(named: "Image_Based_Light") {
                        guard let hdriImageName = appModel.skySphereType?.hdriImageName,
                              let environmentResource = try? await EnvironmentResource(named: hdriImageName)
                        else {
                            ibl.components.set(ImageBasedLightComponent(source: .none))
                            sphere.components.remove(ImageBasedLightReceiverComponent.self)
                            return
                        }
                        ibl.components.set(ImageBasedLightComponent(source: .single(environmentResource)))
                        sphere.components.set(ImageBasedLightReceiverComponent(imageBasedLight: ibl))
                    }
                }
            }
        } attachments: {
            Attachment(id: "Toolbar") {
                if !isShowEnvironmentPicker {
                    HStack {
                        Button {
                            withAnimation {
                                isShowEnvironmentPicker.toggle()
                            }
                        } label: {
                            Text(Image(systemName: "mountain.2.fill"))
                                .font(.title)
                        }
                        .glassBackgroundEffect()
                        
                        ToggleImmersiveSpaceButton(immersiveSpaceId: WindowType.skySphere.rawValue)
                            .glassBackgroundEffect()
                    }
                } else {
                    VStack {
                        HStack {
                            Text("環境")
                                .font(.title)
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    isShowEnvironmentPicker.toggle()
                                }
                            } label: {
                                Text(Image(systemName: "xmark"))
                                    .font(.title)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 32)
                        
                        SkySpherePickerView()
                            .frame(height: 600)
                            .environment(appModel)
                    }
                    .glassBackgroundEffect()
                }
            }
        }
        .onChange(of: appModel.skySphereType) { oldValue, newValue in
            skySphereType = newValue
        }
    }
}
