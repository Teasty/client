// MARK: DataBase

import Alamofire

public enum DataBase {
	static var url: String = "http://212.109.219.69:3006" 
	static var database: String = "/database" 
	static var headers: HTTPHeaders = [
		"content-type": "application/json",
		"x-access-token": String()
	]
	case bonuspoints
	case cartitem
	case category
	case city
	case comment
	case districtpoint
	case document
	case image
	case location
	case order
	case product
	case productlist
	case promocode
	case shop
	case user
}

// MARK: Shema Objects

extension DataBase {
	public func getObject() -> String {
		switch self {
		case .bonuspoints: return "BonusPoints" 
		case .cartitem: return "CartItem" 
		case .category: return "Category" 
		case .city: return "City" 
		case .comment: return "Comment" 
		case .districtpoint: return "DistrictPoint" 
		case .document: return "Document" 
		case .image: return "Image" 
		case .location: return "Location" 
		case .order: return "Order" 
		case .product: return "Product" 
		case .productlist: return "ProductList" 
		case .promocode: return "Promocode" 
		case .shop: return "Shop" 
		case .user: return "User" 
		}
	}
}
