import UIKit
import PlaygroundSupport

//: Playing with structs for source of collection cell details views

enum OfferType: String {
    case normal
    case extraDiscount
    case thunderOffer
    
    func color() -> UIColor {
        switch self {
        case .normal:
            return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        case .extraDiscount:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case .thunderOffer:
            return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
    }
}

struct Decoration {
    
    let offerType: OfferType
    let rect: CGRect
    
    var indicator: UIView! {
        get {
            let indicator:UIView = UIView(frame: rect)
            indicator.layer.cornerRadius = rect.height / 2
            indicator.backgroundColor = offerType.color()
            
            return indicator
        }
    }
}

class TableCell: UITableViewCell {
    
    var deal:Deal! {
        
        didSet {
            setupDealContent()
            setNeedsLayout()
        }
    }
    
    func setupDealContent() {
        let decoration = Decoration(offerType: deal.type, rect: CGRect(x: self.frame.width, y:12, width: 20, height: 20))
        self.contentView.addSubview(decoration.indicator)
        self.textLabel?.text = deal.title
        self.detailTextLabel?.text = deal.type.rawValue
        self.detailTextLabel?.textColor = deal.type.color()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
}




// Testing all...

struct Deal {
    let title: String
    let type:OfferType
}

let deals = [
    Deal(title: "Agua Mineral", type: .normal),
    Deal(title: "Macarrão", type: .extraDiscount),
    Deal(title: "Vassoura", type: .normal),
    Deal(title: "Shampoo", type: .normal),
    Deal(title: "Sabonente", type: .extraDiscount),
    Deal(title: "Remela", type: .thunderOffer),
    Deal(title: "Coleira", type: .extraDiscount),
    Deal(title: "Nutella", type: .thunderOffer)
]

class TVC:UITableViewController {
    
    var deals = [Deal]()
    
    convenience init(deals:[Deal]) {
        self.init(style: .plain)
        self.deals = deals
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        cell.deal = deals[indexPath.row]
        
        return cell
    }
}

let tvc = TVC(deals: deals)
PlaygroundPage.current.liveView = tvc

