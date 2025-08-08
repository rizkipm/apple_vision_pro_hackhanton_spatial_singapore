////
////  GameLogic.swift
////  CandyPlanet
////
////  Kode ini berfungsi sebagai fondasi konseptual untuk game Candy Planet.
////  Kode ini menunjukkan cara membuat entitas permen, menggerakkannya,
////  dan menangani logika game dasar menggunakan RealityKit dan SwiftUI.
////
//
//import SwiftUI
//import RealityKit
//import Combine
//
//// --- 1. Definisi Komponen & Entitas ---
//
///// Komponen untuk mengidentifikasi entitas yang dapat dikoleksi dan nilai skornya.
//struct CollectibleComponent: Component {
//    var scoreValue: Int
//}
//
///// Komponen untuk mengelola pergerakan sebuah entitas.
//struct MovableComponent: Component {
//    var speed: Float
//    var initialSpeed: Float
//}
//
///// Entitas kustom untuk objek permen dalam game.
//class Candy: Entity {
//    enum CandyType {
//        case donut, lollipop, golden
//    }
//
//    // Properti untuk membedakan jenis permen
//    var type: CandyType
//
//    init(type: CandyType) {
//        self.type = type
//        super.init()
//
//        // Tambahkan komponen agar entitas ini bisa bergerak dan dikoleksi
//        // Kecepatan awal diatur secara acak
//        let speed = Float.random(in: 0.5...1.5)
//        self.components.set(MovableComponent(speed: speed, initialSpeed: speed))
//        
//        // Berikan nilai skor yang berbeda untuk Golden Candy
//        let score = (type == .golden) ? 10 : 1
//        self.components.set(CollectibleComponent(scoreValue: score))
//
//        // Buat model visual berdasarkan jenis permen
//        let model: ModelEntity
//        let randomColor = Color(red: Double.random(in: 0.5...1), green: Double.random(in: 0.5...1), blue: Double.random(in: 0.5...1))
//
//        switch type {
//        case .donut:
////            model = ModelEntity(mesh: .generateTorus(radius: 0.07, thickness: 0.03), materials: [SimpleMaterial(color: randomColor, isMetallic: false)])
////            // Tambahkan rotasi untuk membuatnya berputar
////            model.components.set(RotationComponent(speed: .random(in: 0.5...2.0)))
//        case .lollipop:
////            model = ModelEntity(mesh: .generateSphere(radius: 0.06), materials: [SimpleMaterial(color: randomColor, isMetallic: false)])
////            // Permen lollipop melayang dengan rotasi lambat
////            model.components.set(RotationComponent(speed: .random(in: 0.1...0.5)))
//        case .golden:
////            model = ModelEntity(mesh: .generateSphere(radius: 0.05), materials: [SimpleMaterial(color: .yellow, isMetallic: true)])
////            model.components.set(RotationComponent(speed: 3.0)) // Golden candy berputar cepat
//        }
//        self.addChild(model)
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//}
//
//// Komponen opsional untuk rotasi
////struct RotationComponent: Component {
////    var speed: Float
////}
//
//// --- 2. Sistem Logika Game ---
//
///// Sistem yang bertanggung jawab untuk menggerakkan permen.
//class CandyMovementSystem: System {
//    private static let query = EntityQuery(where: .has(MovableComponent.self) && .has(Transform.self))
//    private var collisionCancellable: Cancellable?
//    
//    // Properti untuk menyimpan posisi "tangan" pengguna.
//    // Di aplikasi Vision Pro sesungguhnya, ini akan didapatkan dari input gesture.
//    var userHandPosition: SIMD3<Float> = [0, 0, -0.5]
//
//    required init(scene: RealityKit.Scene) {
//        // Inisialisasi sistem, tidak ada yang dilakukan di sini untuk contoh ini
//    }
//
//    func update(context: SceneUpdateContext) {
//        context.scene.performQuery(Self.query).forEach { entity in
////            guard var movable = entity.components.get(MovableComponent.self) else { return }
//
//            // Hitung jarak ke tangan pengguna
//            let distanceToHand = length(entity.position - userHandPosition)
//            
//            // Logika terapi: Permen melambat saat dekat dengan pengguna (dalam jarak 1 meter)
//            if distanceToHand < 1.0 {
//                let slowdownFactor = distanceToHand / 1.0 // Makin dekat, faktor makin kecil
//                movable.speed = movable.initialSpeed * slowdownFactor
//            } else {
//                movable.speed = movable.initialSpeed
//            }
//
//            // Pindahkan permen ke arah pengguna
//            let direction = normalize(userHandPosition - entity.position)
//            entity.position += direction * movable.speed * context.deltaTime
//
//            // Hapus permen jika terlalu dekat (dianggap "tertangkap")
//            if distanceToHand < 0.1 {
//                entity.parent?.removeChild(entity)
//                // Di sini, Anda akan menambahkan logika untuk meningkatkan skor
//            }
//        }
//    }
//}
//
///// Sistem untuk mengelola rotasi permen
//class RotationSystem: System {
//    private static let query = EntityQuery(where: .has(RotationComponent.self) && .has(Transform.self))
//
//    required init(scene: RealityKit.Scene) {}
//
//    func update(context: SceneUpdateContext) {
//        context.scene.performQuery(Self.query).forEach { entity in
//            guard let rotation = entity.components.get(RotationComponent.self) else { return }
//            
//            // Rotasi entitas di sekitar sumbu Y
//            let rotationAngle = rotation.speed * context.deltaTime
//            entity.transform.rotation *= simd_quatf(angle: rotationAngle, axis: [0, 1, 0])
//        }
//    }
//}
//
//// --- 3. View Model & Integrasi dengan SwiftUI ---
//
//class GameViewModel: ObservableObject {
//    @Published var score: Int = 0
//    private var timer: Timer?
//
//    /// Menambahkan permen ke adegan
//    func spawnCandy(to content: RealityViewContent) {
//        let randomType: Candy.CandyType = [.donut, .lollipop, .golden].randomElement()!
//        let candy = Candy(type: randomType)
//        
//        // Posisikan permen di tempat acak di luar pandangan pengguna
//        let randomX = Float.random(in: -2...2)
//        let randomY = Float.random(in: -1...1)
//        let randomZ = Float.random(in: -4...(-2)) // Mulai di belakang pengguna
//        candy.position = [randomX, randomY, randomZ]
//        
//        content.add(candy)
//    }
//    
//    // Simulasi penangkapan permen
//    func catchCandy(entity: Entity) {
//        if let collectible = entity.components.get(CollectibleComponent.self) {
//            score += collectible.scoreValue
//            entity.parent?.removeChild(entity)
//            print("Candy tertangkap! Skor sekarang: \(score)")
//        }
//    }
//}
//
//struct GameView: View {
//    @StateObject private var viewModel = GameViewModel()
//
//    var body: some View {
//        RealityView { content in
//            // Tambahkan sistem ke adegan
//            let movementSystem = CandyMovementSystem(scene: content.scene)
//            content.addSystem(movementSystem)
//            let rotationSystem = RotationSystem(scene: content.scene)
//            content.addSystem(rotationSystem)
//            
//            // Tambahkan permen awal
//            viewModel.spawnCandy(to: content)
//
//        } update: { content in
//            // Update dipanggil secara berkala, bisa digunakan untuk spawn permen baru
//            if content.scene.entities.count < 3 {
//                viewModel.spawnCandy(to: content)
//            }
//        }
//        .gesture(TapGesture()
//            .targetedToAnyEntity()
//            .onEnded { value in
//                // Simulasikan penangkapan permen saat diklik/di-tap
//                viewModel.catchCandy(entity: value.entity)
//            }
//        )
//        // Tambahkan overlay UI untuk menampilkan skor
//        .overlay(alignment: .bottom) {
//            Text("Skor: \(viewModel.score)")
//                .font(.extraLargeTitle)
//                .padding()
//                .background(.regularMaterial)
//                .cornerRadius(20)
//        }
//    }
//}
//
//// Preview untuk memudahkan pengembangan
//#Preview {
//    GameView()
//}
//
