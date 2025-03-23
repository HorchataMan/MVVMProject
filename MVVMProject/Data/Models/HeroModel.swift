struct HeroModel: Equatable {
    
    let identifier: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool

}

let dummyHero = HeroModel(
    identifier: "William",
    name: "Chupa-Cu",
    description: "El chupa cu de goianinha (Esto es un easter egg)",
    photo: "https://i.imgur.com/1E2uNpN.png",
    favorite: true)
