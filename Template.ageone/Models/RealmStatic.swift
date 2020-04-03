// MARK: Realm Class

import RealmSwift

class Favorite: Object {
    @objc dynamic var hashId: String = String()
    @objc dynamic var name: String = String()
    @objc dynamic var home: String = String()
    @objc dynamic var postalCode: String = String()
    @objc dynamic var street: String = String()
    @objc dynamic var region: String = String()
    @objc dynamic var city: String = String()
    @objc dynamic var country: String = String()
    @objc dynamic var lat: Double = Double()
    @objc dynamic var lng: Double = Double()
    override class func primaryKey() -> String? {
        return "hashId"
    }
}
