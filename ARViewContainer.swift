//
//  ARViewContainer.swift
//  Cosmoclub
//
//  Created by Admin on 27/4/2568 BE.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    var modelName: String?
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
        
        arView.session.run(config)
        context.coordinator.arView = arView
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let modelName = modelName {
            context.coordinator.loadModel(named: modelName)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        weak var arView: ARView?
        var currentModel: String?
        
        func loadModel(named name: String) {
            guard let arView = arView, currentModel != name else { return }
            currentModel = name

            
            arView.scene.anchors.removeAll()
            
            do {
                let modelEntity = try ModelEntity.loadModel(named: name)
                modelEntity.generateCollisionShapes(recursive: true)
                
                let anchor = AnchorEntity(world: [0, 0, -10.0])
                anchor.addChild(modelEntity)
                arView.scene.addAnchor(anchor)
            } catch {
                print("Error loading model: \(error)")
                // Fallback error visualization
                let errorEntity = ModelEntity(mesh: .generateBox(size: 0.1))
                errorEntity.model?.materials = [SimpleMaterial(color: .red, isMetallic: false)]
                let anchor = AnchorEntity(plane: .horizontal)
                anchor.addChild(errorEntity)
                arView.scene.addAnchor(anchor)
            }
        }
    }
}
