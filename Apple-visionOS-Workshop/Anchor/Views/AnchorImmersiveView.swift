//
//  AnchorImmersiveView.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/14.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct AnchorImmersiveView: View {
    
    @Environment(AppModel.self) private var appModel
    
    @GestureState private var tvInitialPosition: EntityTransformState?
    
    var lamborghiniPositionEntity = Entity()
    
    var body: some View {
        RealityView { content, attachments in
            if let tvEntity = try? await Entity(named: "tv", in: realityKitContentBundle) {
                tvEntity.components.set(InputTargetComponent())
                tvEntity.components.set(CollisionComponent(shapes: [.generateBox(size: [60, 60, 60])], mode: .default))
                let tableAnchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.3, 0.3]))
                content.add(tableAnchor)
                tableAnchor.addChild(tvEntity)
            }
            
            if let diamondEntity = try? await Entity(named: "diamond", in: realityKitContentBundle) {
                let handAnchor = AnchorEntity(.hand(.left, location: .joint(for: .ringFingerIntermediateBase)))
                content.add(handAnchor)
                handAnchor.addChild(diamondEntity)
                diamondEntity.scale = [0.01, 0.01, 0.01]
            }
            
            if let shibaEntity = try? await Entity(named: "shiba", in: realityKitContentBundle) {
                let headAnchor = AnchorEntity(.head)
                content.add(headAnchor)
                headAnchor.addChild(shibaEntity)
                shibaEntity.scale = [0.001, 0.001, 0.001]
                shibaEntity.position = [0, 0, -1]
                
                if let toggleImmersiveSpaceButtonAttachment = attachments.entity(for: "ToggleImmersiveSpaceButton") {
                    headAnchor.addChild(toggleImmersiveSpaceButtonAttachment)
                    toggleImmersiveSpaceButtonAttachment.position = [0, -0.15, -1]
                }
            }
            
            if let paintingEntity = try? await Entity(named: "painting", in: realityKitContentBundle) {
                let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: [0.3, 0.3]))
                content.add(wallAnchor)
                wallAnchor.addChild(paintingEntity)
                paintingEntity.transform.rotation = .init(angle: -90 * .pi / 180, axis: [1, 0, 0])
            }
            
            if let lamborghiniEntity = try? await Entity(named: "Lamborghini_Huracán_STO", in: realityKitContentBundle) {
                lamborghiniEntity.components.set(InputTargetComponent())
                lamborghiniEntity.components.set(CollisionComponent(shapes: [.generateBox(size: lamborghiniEntity.scale)], mode: .default))
                let floorAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.3, 0.3]))
                content.add(floorAnchor)
                floorAnchor.addChild(lamborghiniPositionEntity)
                lamborghiniPositionEntity.addChild(lamborghiniEntity)
            }
        } attachments: {
            Attachment(id: "ToggleImmersiveSpaceButton") {
                ToggleImmersiveSpaceButton(immersiveSpaceId: WindowType.anchor.rawValue)
                    .environment(appModel)
            }
        }
        .upperLimbVisibility(.hidden)
        .gesture(
            DragGesture()
                .targetedToEntity(lamborghiniPositionEntity)
                .updating($tvInitialPosition) { update, state, _ in
                    guard let initialState = state else {
                        state = .init(orientation: lamborghiniPositionEntity.orientation, position: lamborghiniPositionEntity.position, scale: lamborghiniPositionEntity.scale)
                        return
                    }
                    let convertedTranslation = update.convert(update.translation3D, from: .local, to: lamborghiniPositionEntity.parent!)
                    lamborghiniPositionEntity.position = initialState.position + convertedTranslation
                }
        )
        .gesture(
            MagnifyGesture()
                .simultaneously(with: RotateGesture3D(constrainedToAxis: .y))
                .targetedToEntity(lamborghiniPositionEntity)
                .updating($tvInitialPosition) { update, state, _ in
                    guard let initialState = state else {
                        state = .init(orientation: lamborghiniPositionEntity.orientation, position: lamborghiniPositionEntity.position, scale: lamborghiniPositionEntity.scale)
                        return
                    }
                    if let scale = update.first?.magnification {
                        let newScale = Float(initialState.scale.x) * Float(scale)
                        lamborghiniPositionEntity.transform.scale = [newScale, newScale, newScale]
                    }
                    
                    if let rotation = update.second?.rotation {
                        let rotationUpdate = simd_quatf(rotation)
                        lamborghiniPositionEntity.transform.rotation = rotationUpdate * initialState.orientation
                    }
                }
        )
    }
}
