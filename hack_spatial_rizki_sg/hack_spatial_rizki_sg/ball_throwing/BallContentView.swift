import SwiftUI

struct BallContentView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var showPlayBall = false
    @Binding var showBallThrowingContent: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Button(action: {
                    showBallThrowingContent = false
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title2)
                        Text("Back")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(25)
                }
                Text("🏀 Ball Throwing Experience")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Get ready for huge baseballs to fly at your face!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Button(action: {
                    Task {
                        switch appModel.immersiveSpaceState {
                        case AppModel.ImmersiveSpaceState.open:
                            appModel.immersiveSpaceState = AppModel.ImmersiveSpaceState.inTransition
                            await dismissImmersiveSpace()
                            appModel.immersiveSpaceState = AppModel.ImmersiveSpaceState.closed
                        case AppModel.ImmersiveSpaceState.closed:
                            appModel.immersiveSpaceState = AppModel.ImmersiveSpaceState.inTransition
                            switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                            case .opened:
                                appModel.immersiveSpaceState = AppModel.ImmersiveSpaceState.open
                            case .error, .userCancelled:
                                appModel.immersiveSpaceState = AppModel.ImmersiveSpaceState.closed
                            @unknown default:
                                appModel.immersiveSpaceState = AppModel.ImmersiveSpaceState.closed
                            }
                        case AppModel.ImmersiveSpaceState.inTransition:
                            break
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: appModel.immersiveSpaceState == AppModel.ImmersiveSpaceState.open ? "xmark.circle" : "play.circle.fill")
                        Text(appModel.immersiveSpaceState == AppModel.ImmersiveSpaceState.open ? "Exit Experience" : "Start Ball Throwing")
                    }
                    .font(.title2)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(appModel.immersiveSpaceState == AppModel.ImmersiveSpaceState.open ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(appModel.immersiveSpaceState == AppModel.ImmersiveSpaceState.inTransition)

                // FREEZE BALL BUTTON - Only when immersive space is open
                if appModel.immersiveSpaceState == AppModel.ImmersiveSpaceState.open {
                    Button(action: {
                        print("🔵 Freeze button pressed!")
                        appModel.requestFreezeOldestBall()
                    }) {
                        VStack {
                            HStack {
                                Image(systemName: "pause.circle.fill")
                                    .font(.title)
                                Text("🧊 FREEZE BALL!")
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            Text("Click to stop the oldest ball mid-air")
                                .font(.caption)
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .background(Color.cyan)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .shadow(color: .cyan.opacity(0.5), radius: 10)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }

                if appModel.immersiveSpaceState == AppModel.ImmersiveSpaceState.open {
                    VStack(spacing: 15) {
                        Text("🥽 Immersive Experience Active")
                            .font(.headline)
                            .foregroundColor(.green)
                        Text("Huge baseballs are flying at your face every 3-5 seconds")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        Text("💡 Click the FREEZE button to stop balls mid-air!")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.cyan)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Tips:")
                        .font(.headline)
                    Text("• Massive baseballs will fill your entire field of view")
                    Text("• They fly directly at your face from a distance")
                    Text("• Use the FREEZE button to stop them mid-air")
                    Text("• Frozen balls turn blue and stay suspended in space")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding(40)
        }
    }
}

#Preview(windowStyle: .automatic) {
    BallContentView(showBallThrowingContent: .constant(true))
        .environment(AppModel())
    
//    ZenGardenView(showZenGarden: .constant(true))
}
