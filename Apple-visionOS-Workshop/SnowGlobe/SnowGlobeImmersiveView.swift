//
//  SnowGlobeImmersiveView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/18.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SnowGlobeImmersiveView: View {
    
    @Environment(AppModel.self) private var appModel
    
    @GestureState private var snowGlobeInitialPosition: EntityTransformState?
    
    @State private var snowGlobeEntity = Entity()
    @State private var buttonEntity = Entity()
    @State private var isTrainAnimating = false
    
    private let realityKitNotificationPublisher = NotificationCenter.default.publisher(for: .init("RealityKit.NotificationTrigger")).compactMap(RealityKitNotification.init)
    
    var body: some View {
        RealityView { content, attachments in
            guard let snowGlobe = try? await Entity(named: "SnowGlobe", in: realityKitContentBundle) else { return }
            self.snowGlobeEntity = snowGlobe
            content.add(self.snowGlobeEntity)
            self.snowGlobeEntity.position = [0, 1.2, -1.2]
            
            guard let button = snowGlobe.findEntity(named: "Button") else { return }
            self.buttonEntity = button
            self.buttonEntity.components.set(InputTargetComponent())
            self.buttonEntity.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
            self.buttonEntity.components.set(HoverEffectComponent())
            
            guard let toggleImmersiveSpaceButtonAttachment = attachments.entity(for: "ToggleImmersiveSpaceButton") else { return }
            let leftHandPalmAnchor = AnchorEntity(.hand(.left, location: .aboveHand))
            content.add(leftHandPalmAnchor)
            leftHandPalmAnchor.addChild(toggleImmersiveSpaceButtonAttachment)
            toggleImmersiveSpaceButtonAttachment.transform.rotation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
            toggleImmersiveSpaceButtonAttachment.position.z -= 0.01
        } attachments: {
            Attachment(id: "ToggleImmersiveSpaceButton") {
                ToggleImmersiveSpaceButton(immersiveSpaceId: WindowType.anchor.rawValue)
                    .glassBackgroundEffect()
                    .environment(appModel)
            }
        }
        .gesture(buttonTapGesture)
        .gesture(
            DragGesture()
                .targetedToEntity(self.snowGlobeEntity)
                .updating($snowGlobeInitialPosition) { update, state, _ in
                    guard let initialState = state else {
                        state = .init(orientation: self.snowGlobeEntity.orientation, position: self.snowGlobeEntity.position, scale: self.snowGlobeEntity.scale)
                        return
                    }
                    let convertedTranslation = update.convert(update.translation3D, from: .local, to: self.snowGlobeEntity.parent!)
                    self.snowGlobeEntity.position = initialState.position + convertedTranslation
                }
        )
        .gesture(
            MagnifyGesture()
                .simultaneously(with: RotateGesture3D(constrainedToAxis: .y))
                .targetedToEntity(self.snowGlobeEntity)
                .updating($snowGlobeInitialPosition) { update, state, _ in
                    guard let initialState = state else {
                        state = .init(orientation: self.snowGlobeEntity.orientation, position: self.snowGlobeEntity.position, scale: self.snowGlobeEntity.scale)
                        return
                    }
                    if let scale = update.first?.magnification {
                        let newScale = Float(initialState.scale.x) * Float(scale)
                        self.snowGlobeEntity.transform.scale = [newScale, newScale, newScale]
                    }
                    
                    if let rotation = update.second?.rotation {
                        let rotationUpdate = simd_quatf(rotation)
                        self.snowGlobeEntity.transform.rotation = rotationUpdate * initialState.orientation
                    }
                }
        )
        .onReceive(realityKitNotificationPublisher) { notification in
            switch notification.id {
            case "TrainAnimationStart":
                isTrainAnimating = true
            case "TrainAnimationStop":
                isTrainAnimating = false
            default:
                break
            }
        }
    }
    
    var buttonTapGesture: some Gesture {
        TapGesture()
            .targetedToEntity(self.buttonEntity)
            .onEnded { _ in
                if !isTrainAnimating {
                    guard self.buttonEntity.applyTapForBehaviors() else { return }
                }
            }
    }
}
