import SwiftUI

@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    
    var immersiveSpaceState = ImmersiveSpaceState.closed

    // Ball freezing system
    var frozenBallIDs: Set<UUID> = []
    var freezeRequestBallID: UUID? = nil
    var activeBallIDs: [UUID] = []
    
    // Request to freeze the oldest unfrozen ball
    func requestFreezeOldestBall() {
        if let oldest = activeBallIDs.first(where: { !frozenBallIDs.contains($0) }) {
            freezeRequestBallID = oldest
        } else {
            freezeRequestBallID = nil
        }
    }

    func freezeBall(id: UUID) {
        frozenBallIDs.insert(id)
        freezeRequestBallID = nil
    }
    
    func unfreezeBall(id: UUID) {
        frozenBallIDs.remove(id)
    }
}
