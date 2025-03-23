
import UIKit

class HeroCell: UITableViewCell {

    static let reuseIdentifier = "HeroCell"
    static let height: CGFloat = 90
    
    @IBOutlet weak var heroName: UILabel!
    
    @IBOutlet weak var heroImage: AsyncImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroImage.layer.cornerRadius = heroImage.frame.width/2
        heroImage.clipsToBounds = true
    }
    
    func setData(name: String, photo: String) {
        heroName.text = name
        
        heroImage.setImage(photo)
        
    }
    
}
