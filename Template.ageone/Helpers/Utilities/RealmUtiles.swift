// MARK: Realm Utiles

import RealmSwift
import RxCocoa
import RxSwift

extension Utiles {

    class RealmUtilles {
       let address = AddressUtiles()
       let car = CarUtiles()
       let config = ConfigUtiles()
       let document = DocumentUtiles()
       let driverdocument = DriverDocumentUtiles()
       let image = ImageUtiles()
       let msg = MsgUtiles()
       let order = OrderUtiles()
       let payment = PaymentUtiles()
       let stop = StopUtiles()
       let tariff = TariffUtiles()
       let user = UserUtiles()
       let wishlist = WishListUtiles()
       let wishlistvalue = WishListValueUtiles()
    }

    struct AddressUtiles {

        public let eventBus = "eventBusObserveRealmAddress"

        public func getObjects() -> [Address] {
            let realm = try! Realm()
            return Array(realm.objects(Address.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Address> {
            let realm = try! Realm()
            return realm.objects(Address.self)
        }

        public func getObjectsById(_ objectId: String) -> Address? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Address.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct CarUtiles {

        public let eventBus = "eventBusObserveRealmCar"

        public func getObjects() -> [Car] {
            let realm = try! Realm()
            return Array(realm.objects(Car.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Car> {
            let realm = try! Realm()
            return realm.objects(Car.self)
        }

        public func getObjectsById(_ objectId: String) -> Car? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Car.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct ConfigUtiles {

        public let eventBus = "eventBusObserveRealmConfig"

        public func getObjects() -> [Config] {
            let realm = try! Realm()
            return Array(realm.objects(Config.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Config> {
            let realm = try! Realm()
            return realm.objects(Config.self)
        }

        public func getObjectsById(_ objectId: String) -> Config? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Config.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct DocumentUtiles {

        public let eventBus = "eventBusObserveRealmDocument"

        public func getObjects() -> [Document] {
            let realm = try! Realm()
            return Array(realm.objects(Document.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Document> {
            let realm = try! Realm()
            return realm.objects(Document.self)
        }

        public func getObjectsById(_ objectId: String) -> Document? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Document.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct DriverDocumentUtiles {

        public let eventBus = "eventBusObserveRealmDriverDocument"

        public func getObjects() -> [DriverDocument] {
            let realm = try! Realm()
            return Array(realm.objects(DriverDocument.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<DriverDocument> {
            let realm = try! Realm()
            return realm.objects(DriverDocument.self)
        }

        public func getObjectsById(_ objectId: String) -> DriverDocument? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: DriverDocument.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct ImageUtiles {

        public let eventBus = "eventBusObserveRealmImage"

        public func getObjects() -> [Image] {
            let realm = try! Realm()
            return Array(realm.objects(Image.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Image> {
            let realm = try! Realm()
            return realm.objects(Image.self)
        }

        public func getObjectsById(_ objectId: String) -> Image? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Image.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct MsgUtiles {

        public let eventBus = "eventBusObserveRealmMsg"

        public func getObjects() -> [Msg] {
            let realm = try! Realm()
            return Array(realm.objects(Msg.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Msg> {
            let realm = try! Realm()
            return realm.objects(Msg.self)
        }

        public func getObjectsById(_ objectId: String) -> Msg? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Msg.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct OrderUtiles {

        public let eventBus = "eventBusObserveRealmOrder"

        public func getObjects() -> [Order] {
            log.info(Realm.Configuration.defaultConfiguration.fileURL)
            let realm = try! Realm()
            return Array(realm.objects(Order.self).sorted(byKeyPath: "created" ).filter({$0.isExist}))
        }

        public func getResults() -> Results<Order> {
            let realm = try! Realm()
            return realm.objects(Order.self)
        }

        public func getObjectsById(_ objectId: String) -> Order? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Order.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct PaymentUtiles {

        public let eventBus = "eventBusObserveRealmPayment"

        public func getObjects() -> [Payment] {
            let realm = try! Realm()
            return Array(realm.objects(Payment.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Payment> {
            let realm = try! Realm()
            return realm.objects(Payment.self)
        }

        public func getObjectsById(_ objectId: String) -> Payment? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Payment.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct StopUtiles {

        public let eventBus = "eventBusObserveRealmStop"

        public func getObjects() -> [Stop] {
            let realm = try! Realm()
            return Array(realm.objects(Stop.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Stop> {
            let realm = try! Realm()
            return realm.objects(Stop.self)
        }

        public func getObjectsById(_ objectId: String) -> Stop? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Stop.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct TariffUtiles {

        public let eventBus = "eventBusObserveRealmTariff"

        public func getObjects() -> [Tariff] {
            let realm = try! Realm()
            return Array(realm.objects(Tariff.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<Tariff> {
            let realm = try! Realm()
            return realm.objects(Tariff.self)
        }

        public func getObjectsById(_ objectId: String) -> Tariff? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: Tariff.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct UserUtiles {

        public let eventBus = "eventBusObserveRealmUser"

        public func getObjects() -> [User] {
            let realm = try! Realm()
            return Array(realm.objects(User.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<User> {
            let realm = try! Realm()
            return realm.objects(User.self)
        }

        public func getObjectsById(_ objectId: String) -> User? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: User.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct WishListUtiles {

        public let eventBus = "eventBusObserveRealmWishList"

        public func getObjects() -> [WishList] {
            let realm = try! Realm()
            return Array(realm.objects(WishList.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<WishList> {
            let realm = try! Realm()
            return realm.objects(WishList.self)
        }

        public func getObjectsById(_ objectId: String) -> WishList? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: WishList.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

    struct WishListValueUtiles {

        public let eventBus = "eventBusObserveRealmWishListValue"

        public func getObjects() -> [WishListValue] {
            let realm = try! Realm()
            return Array(realm.objects(WishListValue.self).filter({$0.isExist}))
        }

        public func getResults() -> Results<WishListValue> {
            let realm = try! Realm()
            return realm.objects(WishListValue.self)
        }

        public func getObjectsById(_ objectId: String) -> WishListValue? {
            let realm = try! Realm()
            guard let object = realm.object(ofType: WishListValue.self, forPrimaryKey: objectId) else { return nil }
            if object.isExist {
                return object
            } else {
                return nil
            }
        }

    }

}
