final class HeroDTOToHeroModelMapper {
    func map(_ dto: HeroDTO) -> HeroModel {
        
        
        return HeroModel(identifier: dto.identifier,
                  name: dto.name,
                  description: dto.description,
                  photo: dto.photo,
                  favorite: dto.favorite)
    }
}

